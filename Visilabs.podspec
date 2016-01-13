#
# Be sure to run `pod lib lint Visilabs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Visilabs'
  s.version          = "2.4.1"
  s.summary          = "Visilabs IOS SDK for Analytics and Target modules."
  s.description      = "Visilabs IOS SDK for Analytics and Target modules. SDK tracks user interactions and makes recommendations to enhance conversion and user retention."
  s.homepage         = "http://www.visilabs.com"
  s.license          = 'Visilabs'
  s.author           = { "visilabs" => "egemen@visilabs.com" }
  s.source           = { :git => "https://github.com/visilabs/Visilabs-IOS.git", :tag => s.version.to_s }
  s.social_media_url = 'https://www.facebook.com/visilabs/'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.default_subspec = 'Visilabs'

  s.subspec 'Visilabs' do |ss|
    ss.source_files  = 'Visilabs/**/*.{m,h}', 'Visilabs/**/*.swift'
    ss.resources 	 = ['Visilabs/**/*.{png,storyboard}']
  end


end
