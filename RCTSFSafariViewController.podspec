
Pod::Spec.new do |s|
  s.name         = "RCTSFSafariViewController"
  s.version      = "1.1.0"
  s.summary      = "RCTSFSafariViewController"
  s.homepage     = "https://github.com/psomialbert/react-native-sfsafariviewcontroller"
  s.license      = "MIT"
  s.author       = { "albert schapiro" => "albert@schapiro.se" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/psomialbert/react-native-sfsafariviewcontroller.git", :tag => "master" }
  s.source_files = "**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"

end
