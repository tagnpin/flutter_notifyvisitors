#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_notifyvisitors.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_notifyvisitors'
  s.version          = '1.6.6'
  s.summary          = 'NotifyVisitors Flutter SDK for marketing automation software that designed to help marketers take their campaigns to the next level.'
  s.description      = 'NotifyVisitors sdk to attribute and analyse user behaviour analytics like funnel, cohort, RFM also used to increase Mobile App engagement through push notification, in-app nudges.'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.homepage         = 'http://www.nvecta.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mohammad Ashraf Ali' => 'ashraf@nvecta.com' }
  s.source           = { :path => '.' }

  s.ios.deployment_target = '13.0'
  s.static_framework = true
  s.dependency 'notifyvisitors', '8.0.2'
  s.dependency 'notifyvisitorsNudges', '0.0.3'
  
  s.source_files = 'flutter_notifyvisitors/Sources/flutter_notifyvisitors/**/*.{h,m}'
  s.public_header_files = 'flutter_notifyvisitors/Sources/flutter_notifyvisitors/**/*.h'

  # Cleaned config (removed EXCLUDED_ARCHS[sdk=iphonesimulator*] = arm64)
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'OTHER_LDFLAGS' => '-lObjC'
  }
  
  s.swift_version = '5.0'
  
end
