Pod::Spec.new do |s|
  s.name        = "Engine"
  s.version     = "1.0.1"
  s.summary     = "Data driven architecture framework in Swift"
  s.homepage    = "https://github.com/siam-biswas/Engine"
  s.license     = { :type => "MIT" }
  s.authors     = { "Siam Biswas" => "siam.biswas@icloud.com" }

  s.requires_arc = true
  s.swift_version = "4.2"
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/siam-biswas/Engine.git", :tag => s.version }
  s.source_files = "Source/Engine/*.swift"
end
