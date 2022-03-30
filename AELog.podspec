Pod::Spec.new do |s|

s.name = 'AELog'
s.version = '0.6.2'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Simple, lightweight and flexible debug logging minion written in Swift'

s.source = { :git => 'https://github.com/tadija/AELog.git', :tag => s.version }
s.source_files = 'Sources/AELog/*.swift'

s.swift_versions = ['4.0', '4.2', '5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '5.6']

s.ios.deployment_target = '12.0'
s.watchos.deployment_target = '3.0'
s.tvos.deployment_target = '12.0'
s.osx.deployment_target = '10.10'

s.homepage = 'https://github.com/tadija/AELog'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

end
