#
#  Be sure to run `pod spec lint BraspagSilentOrderPost.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "BraspagSilentOrderPost"
  spec.version      = "0.0.1"
  spec.summary      = "Braspag silent order post it's an easy way to validate credit card and get a valid token."

  spec.description  = <<-DESC
  O SDK Silent Order Post é uma integração que a Braspag oferece aos lojistas, onde os dados de pagamentos são trafegados de forma segura, mantendo o controle total sobre a experiência de checkout.
                   DESC

  spec.homepage     = "https://github.com/braspag/silent_order_post_ios"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "Jeferson F. Nazario" => "jefnazario@gmail.com" }
  spec.social_media_url   = "http://twitter.com/jefnazario"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/braspag/silent_order_post_ios.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = '9.0'


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "BraspagSilentOrderPost/BraspagSilentOrderPost/**/*.{h,m,swift,framework}"
  spec.exclude_files = "Example/*.*"

end
