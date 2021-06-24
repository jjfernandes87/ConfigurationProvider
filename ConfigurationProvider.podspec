Pod::Spec.new do |s|
s.name             = 'ConfigurationProvider'
s.version          = '2.1.0'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.summary          = 'ConfigurationProvider is a pod that encompasses all access to the apps internal configuration files (plist).'
s.homepage         = 'https://github.com/jjfernandes87/ConfigurationProvider'
s.social_media_url = 'https://twitter.com/jfernandes87'
s.author           = { 'jjfernandes87' => 'julio.fernandes87@gmail.com' }
s.source           = { :git => 'https://github.com/jjfernandes87/ConfigurationProvider.git', :tag => s.version }

s.ios.deployment_target = '9.3'
s.source_files = 'Sources/**/*'

end
