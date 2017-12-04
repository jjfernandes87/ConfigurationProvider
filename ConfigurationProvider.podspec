#
# Be sure to run `pod lib lint ConfigurationProvider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'ConfigurationProvider'
s.version          = '0.0.5'
s.summary          = 'ConfigurationProvider is a pod that encompasses all access to the apps internal configuration files (plist).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
When creating the Configuration file you can create different environments and add configurations in each version.
You must also add the Scheme key in your app's info.plist and tell which environment you are using.
DESC

s.homepage         = 'https://github.com/jjfernandes87/ConfigurationProvider'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'jjfernandes87' => 'julio.fernandes87@gmail.com' }
s.source           = { :git => 'https://github.com/jjfernandes87/ConfigurationProvider.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/jfernandes87'
s.ios.deployment_target = '9.3'
s.source_files = 'ConfigurationProvider/Classes/**/*'

end

