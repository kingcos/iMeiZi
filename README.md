# iMeiZi

A demo app browse beauties from web.

## Preface

该 Repo 为 [Sunnyyoung/Meizi](https://github.com/Sunnyyoung/Meizi) 的 Swift 3.x 版本。

项目整体使用了 MVC 架构，使用了部分第三方框架完成。实现了瀑布流显示图片，以及清除缓存等功能。App 的 Icon 简要使用了 Sketch 绘制导出，可以在 `Design` 文件夹下查看。

## How to run?

Clone 或下载后，`pod install` 即可。

## ScreenShots

![](ScreenShots/Functions.gif)

## Podfile

```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iMeiZi' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iMeiZi
  
  # Fabric
  pod 'Fabric'
  pod 'Crashlytics'
  
  # Photo browser
  pod 'SKPhotoBrowser'
  
  # Image from web
  pod 'Kingfisher'
  
  # HUD
  pod 'PKHUD'
  
  # JSON
  pod 'HandyJSON'
  
  # Dropdown menu
  pod 'BTNavigationDropdownMenu', :git =>
  'https://github.com/PhamBaTho/BTNavigationDropdownMenu.git'
  
  # Refresh
  pod 'MJRefresh'

end
```

## LICENSE

MIT