#
#  Be sure to run `pod spec lint XHPageControl.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "XHPageControl"
  spec.version      = "1.0.0"
  spec.summary      = "A pageControl used on iOS."

  spec.description  = <<-DESC
                  It is a pageControl used on iOS, which implement by Objective-C.
                   DESC

  spec.homepage     = "https://github.com/zxhkit/XHPageControl"
  spec.license      = "MIT"
  spec.author             = { "zhouxuanhe" => "1152167469@qq.com" }
  spec.source       = { :git => "https://github.com/zxhkit/XHPageControl.git", :tag => "spec.version.to_s" }



  spec.platform     = :ios, "5.0"

  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  spec.requires_arc = true
  

  spec.source_files  = "XHPageControl/*"
  #spec.exclude_files = "Classes/Exclude"

  
  spec.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

  

end
