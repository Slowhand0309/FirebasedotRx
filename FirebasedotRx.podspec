Pod::Spec.new do |s|
  s.name             = 'FirebasedotRx'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift extensions for Firebase.'
  s.description      = <<-DESC
  A RxSwift extensions for Firebase (Authentication, Realtime Database, Cloud Firestore, Storage).
  DESC

  s.homepage         = 'https://github.com/Slowhand0309/FirebasedotRx'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Slowhand0309' => 'slowhand0309@gmail.com' }
  s.source           = { :git => 'https://github.com/Slowhand0309/FirebasedotRx.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FirebasedotRx/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FirebasedotRx' => ['FirebasedotRx/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'RxSwift'
  s.dependency 'Firebase/Core', '~> 5.0'
  s.dependency 'Firebase/Database', '~> 5.0'
  s.dependency 'Firebase/Auth', '~> 5.0'
  s.dependency 'Firebase/Firestore'
  s.dependency 'Firebase/Storage'
end
