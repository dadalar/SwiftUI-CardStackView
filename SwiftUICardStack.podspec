Pod::Spec.new do |s|
  s.name             = 'SwiftUICardStack'
  s.version          = '0.0.3'
  s.summary          = 'A easy-to-use SwiftUI view for Tinder like cards on iOS, macOS & watchOS.'

  s.homepage         = 'https://github.com/dadalar/SwiftUI-CardStackView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Deniz Adalar' => 'me@dadalar.net' }
  s.source           = { :git => 'https://github.com/dadalar/SwiftUI-CardStackView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.watchos.deployment_target = '6.0'
  s.swift_version   = '5.1'

  s.source_files     = 'Sources/**/*'

end
