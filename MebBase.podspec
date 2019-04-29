#
# Be sure to run `pod lib lint MebBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MebBase'
  s.version          = '0.1.2'
  s.summary          = 'MebBase'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MebBase contain some base component.
                       DESC

  s.homepage         = 'https://github.com/ysfox/MebBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ysfox' => '327302008@qq.com' }
  s.source           = { :git => 'https://github.com/ysfox/MebBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'MebBase/Classes/**/*'
  s.subspec 'Base' do |base|
    base.source_files = 'MebBase/Classes/Base/**/*'
  end

  s.subspec 'Category' do |category|
    category.source_files = 'MebBase/Classes/Category/**/*'
  end

  s.subspec 'Utils' do |utils|
    utils.source_files = 'MebBase/Classes/Utils/**/*'
  end
  
  # s.resource_bundles = {
  #   'MebBase' => ['MebBase/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
