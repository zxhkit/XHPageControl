

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
  spec.source       = { :git => "https://github.com/zxhkit/XHPageControl.git", :tag => "1.0.0" }


#spec.version.to_s
  spec.platform     = :ios, "4.3"

  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  spec.requires_arc = true
  

  spec.source_files  = "XHPageControl/*"
  #spec.exclude_files = "Classes/Exclude"

  
  spec.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

  

end
