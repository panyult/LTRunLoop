#
# Be sure to run `pod lib lint LTRunLoop.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'LTRunLoop'
s.version          = '0.1.0'
s.summary          = 'LTRunLoop help you to define self-define input source when you want use a secondary thread\'s run loop to handle something for you.'

s.description      = 'Using LTRunLoop you can just deliver your pending data,which needs to be handled on a secondary thread by the the method you provide,then LTRunLoop help you create a secondary thread and run the run loop of the thread to dispatch your data via input source.Finally,the run loop will invoke your method to handle the data,as an argument passed in,which you had delivered.LTRunLoop let you focus on input and hanlers of data.'

s.homepage         = 'https://github.com/panyult/LTRunLoop'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'panyult' => 'litaoxiwang@163.com' }
s.source           = { :git => 'https://github.com/panyult/LTRunLoop.git', :tag => s.version }
s.social_media_url = 'https://twitter.com/panyu_lt'

s.ios.deployment_target = '8.0'
s.platform     = :ios, '8.0'
s.requires_arc = true
s.source_files = 'LTRunLoop/Classes/**/*'
s.frameworks   = 'UIKit,Foundation,CoreFoundation'
# s.resource_bundles = {
#   'LTRunLoop' => ['LTRunLoop/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end

