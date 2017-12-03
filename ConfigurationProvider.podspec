#
# Be sure to run `pod lib lint ConfigurationProvider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ConfigurationProvider'
  s.version          = '0.0.2'
  s.summary          = 'ConfigurationProvider é um pod que engloba todo o acesso aos arquivos de configuração interna (plist) do app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Ao criar o arquivo Configuration você pode criar ambientes diferentes e adicionar configurações em cada versão.
É necessário também adicionar a chave Scheme no info.plist do seu app e informar qual ambiente você esta usando.
                       DESC

  s.homepage         = 'https://github.com/jjfernandes87/ConfigurationProvider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jjfernandes87' => 'julio.fernandes87@gmail.com' }
  s.source           = { :git => 'https://github.com/jjfernandes87/ConfigurationProvider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jfernandes87'
  s.ios.deployment_target = '9.3'
  s.source_files = 'ConfigurationProvider/Classes/**/*'

end
