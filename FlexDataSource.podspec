#
# Be sure to run `pod lib lint FlexDataSource.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexDataSource'
  s.version          = '0.1.2'
  s.summary          = 'FlexDataSource makes it dead simple to create table views with multiple types of cells coexisting.'
  s.swift_versions   = ['4.0', '4.1', '4.2', '5.0', '5.1', '5.2']

  s.description      = <<-DESC
This pod moves configuration from the data source to individual cell model classes. By doing so, it becomes straightforward to mix and match cells within the same UITableView.
                       DESC

  s.homepage         = 'https://github.com/ThryvInc/flex-data-source'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Elliot' => '' }
  s.source           = { :git => 'https://github.com/ThryvInc/flex-data-source.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/elliot_schrock'

  s.ios.deployment_target = '11.0'

  s.source_files = 'FlexDataSource/Classes/**/*'
  s.dependency 'fuikit'
end
