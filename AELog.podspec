Pod::Spec.new do |s|

s.name = 'AELog'
s.version = '0.5.6'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Simple, lightweight and flexible debug logging minion written in Swift'

s.source = { :git => 'https://github.com/tadija/AELog.git', :tag => s.version }
s.source_files = 'Sources/AELog/*.swift'

s.swift_version = '4.2'

s.ios.deployment_target = '8.0'
s.watchos.deployment_target = '2.0'
s.tvos.deployment_target = '9.0'
s.osx.deployment_target = '10.10'

s.homepage = 'https://github.com/tadija/AELog'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

end
