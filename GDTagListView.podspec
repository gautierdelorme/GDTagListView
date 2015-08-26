#
# Be sure to run `pod lib lint GDTagListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GDTagListView"
  s.version          = "0.1.0"
  s.summary          = "UIView subclass that allows to add a list of customizable tags."
  s.homepage         = "https://github.com/gautierdelorme/GDTagListView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Gautier Delorme" => "waken31@gmail.com" }
  s.source           = { :git => "https://github.com/gautierdelorme/GDTagListView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/delormegautier'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GDTagListView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
