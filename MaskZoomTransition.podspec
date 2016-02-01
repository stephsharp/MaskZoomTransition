Pod::Spec.new do |s|
  s.name         = "MaskZoomTransition"
  s.version      = "0.1"
  s.summary      = "A Material Design-inspired transition."
  s.homepage     = "https://github.com/stephsharp/MaskZoomTransition"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Stephanie Sharp"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/stephsharp/MaskZoomTransition.git", :tag => "v#{s.version}" }
  s.source_files = "MaskZoomTransition"
  s.public_header_files = [ "MaskZoomTransition/MZMaskZoomTransition.h", 
                            "MaskZoomTransition/MZMaskZoomTransitioningDelegate.h", 
                            "MaskZoomTransition/UIViewController+MZContentViewController.h" ]
  s.requires_arc = true
end
