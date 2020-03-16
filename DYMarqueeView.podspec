
Pod::Spec.new do |s|


  s.name         = "DYMarqueeView"
  s.version      = "1.0.0"
  s.summary      = "一个可以高度自定义的iOS跑马灯。"

  s.description  = <<-DESC
                    一个可以高度自定义的iOS跑马灯,支持双向模式。
                   DESC

  s.homepage     = "https://github.com/duyi56432/DYMarqueeView"

  s.license      = "MIT"

  s.author             = { "duyi56432" => "564326678@qq.com" }
  s.frameworks   = "Foundation"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/duyi56432/DYMarqueeView.git", :tag => "#{s.version}" }


  s.source_files  = "DYMarqueeView/**/*.{h,m}"


end
