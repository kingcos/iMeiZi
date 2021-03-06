//
//  PhotosController.swift
//  iMeiZi
//
//  Created by kingcos on 14/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import MJRefresh
import SKPhotoBrowser

class PhotosController: UIViewController {
    
    let arr = ["全部", "大胸", "翘臀", "黑丝", "美臀", "清新", "杂烩"]
    let dict: [String: PhotoCategory] = [
        "全部": .all,
        "大胸": .daXiong,
        "翘臀": .qiaoTun,
        "黑丝": .heiSi,
        "美臀": .meiTui,
        "清新": .qingXin,
        "杂烩": .zaHui
    ]
    
    var photoCategory = PhotoCategory.all
    var page = 1
    
    var photos = [SKPhoto]()
    
    var iMeiZiArray: [MeiZi]? {
        didSet {
            guard let iMeiZiArray = iMeiZiArray else { return }
            photos.removeAll()
            _ = iMeiZiArray.map { iMeiZi in
                guard let url = iMeiZi.imageURL else { return }
                photos.append(SKPhoto.photoWithImageURL(url))
            }
        }
    }
    
    lazy var collectionView: UICollectionView? = { [weak self] in
        guard let strongSelf = self else { return nil }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: PHOTOS_COLLECTION_ITEM_WIDTH,
                                 height: PHOTOS_COLLECTION_ITEM_HEIGHT)
        layout.minimumLineSpacing = PHOTOS_LINE_SPACE
        layout.minimumInteritemSpacing = 0.0
        
        let view = UICollectionView(frame: strongSelf.view.bounds,
                                    collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.register(UINib(nibName: String(describing: PhotoCell.self),
                            bundle: nil),
                      forCellWithReuseIdentifier: PHOTO_CELL_ID)
        
        view.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        view.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

extension PhotosController {
    func setup() {
        setupLogic()
        setupUI()
    }
    
    private func setupLogic() {
        Network.getWith(photoCategory, in: 1) { json in
            if let composition = Result.deserialize(from: json) {
                self.iMeiZiArray = composition.results
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    private func setupUI() {
        let menuView = BTNavigationDropdownMenu(title: BTTitle.index(0),
                                                items: arr)
        navigationItem.titleView = menuView
        menuView.didSelectItemAtIndexHandler = { [weak self] indexPath in
            guard let strongSelf = self,
                let category = strongSelf.dict[strongSelf.arr[indexPath]] else { return }
            Network.getWith(category, in: 1) { json in
                if let composition = Result.deserialize(from: json) {
                    strongSelf.photoCategory = category
                    strongSelf.iMeiZiArray = composition.results
                    
                    DispatchQueue.main.async {
                        strongSelf.collectionView?.reloadData()
                    }
                }
            }
        }
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        collectionView.mj_header.beginRefreshing()
    }
}

extension PhotosController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iMeiZiArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PHOTO_CELL_ID,
                                                      for: indexPath)
        
        if let cell = cell as? PhotoCell {
            cell.iMeizi = iMeiZiArray?[indexPath.row]
        }
        
        return cell
    }
}

extension PhotosController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let browser = SKPhotoBrowser(photos: photos)
        browser.initializePageIndex(indexPath.row)
        present(browser, animated: true)
    }
}

extension PhotosController {
    func headerRefresh() {
        collectionView?.mj_header.endRefreshing()
        Network.getWith(photoCategory, in: 1) { json in
            if let composition = Result.deserialize(from: json) {
                self.iMeiZiArray = composition.results
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func footerRefresh() {
        collectionView?.mj_footer.endRefreshing()
        Network.getWith(photoCategory, in: page + 1) { json in
            if let composition = Result.deserialize(from: json),
                let results = composition.results {
                self.page += 1
                for result in results {
                    self.iMeiZiArray?.append(result)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
}
