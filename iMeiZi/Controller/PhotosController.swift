//
//  PhotosController.swift
//  iMeiZi
//
//  Created by kingcos on 14/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit

class PhotosController: UIViewController {
    
    var iMeiZiArray: [MeiZi]?
    
    lazy var collectionView: UICollectionView? = { [weak self] in
        guard let strongSelf = self else { return nil }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: PHOTOS_COLLECTION_ITEM_WIDTH,
                                 height: PHOTOS_COLLECTION_ITEM_HEIGHT)
        layout.minimumLineSpacing = PHOTOS_LINE_SPACE
        layout.minimumInteritemSpacing = 0.0
        
        let view = UICollectionView(frame: strongSelf.view.bounds,
                                    collectionViewLayout: layout)
        view.dataSource = self
        view.backgroundColor = .white
        view.register(UINib(nibName: String(describing: PhotoCell.self),
                            bundle: nil),
                      forCellWithReuseIdentifier: PHOTO_CELL_ID)
        
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
        Network.getWith(.all, in: 1) { json in
            if let composition = Result.deserialize(from: json) {
                self.iMeiZiArray = composition.results
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    private func setupUI() {
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
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
