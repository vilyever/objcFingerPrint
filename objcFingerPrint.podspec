#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "objcFingerPrint"
  s.version          = "1.0.0"
  s.summary          = "objcFingerPrint"
  s.description      = <<-DESC
                       objcFingerPrint
                       DESC
  s.homepage         = "https://github.com/vilyever"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "vilyever" => "vilyever@gmail.com" }
  s.source           = { :git => "https://github.com/vilyever/objcFingerPrint.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/vilyever'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'objcFingerPrint/**/*.{h,m}'
# s.resource_bundles = {
#   'objcFingerPrint' => ['objcFingerPrint/**/*.png']
# }

  s.public_header_files = 'objcFingerPrint/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'objcBlock'
  s.dependency 'objcWindow'
  s.dependency 'objcView'


end
