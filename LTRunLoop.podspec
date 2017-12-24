
Pod::Spec.new do |s|
s.name             = 'LTRunLoop'
s.version          = '0.1.1'
s.summary          = 'LTRunLoop help you to define self-define input source when you want use the run loop of a secondary thread to handle something for you.'
s.homepage         = 'https://github.com/panyult/LTRunLoop'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'panyult' => 'litaoxiwang@163.com' }
s.source           = { :git => 'https://github.com/panyult/LTRunLoop.git', :tag => s.version }
s.platform         = :ios, '8.0'
s.requires_arc     = true
s.source_files     = 'LTRunLoop/**/*.{h,m}'
s.frameworks       = 'UIKit', 'Foundation', 'CoreFoundation'

end

