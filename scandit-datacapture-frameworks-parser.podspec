Pod::Spec.new do |s|
    s.name                    = 'scandit-datacapture-frameworks-parser'
    s.version                 = '7.3.2'
    s.summary                 = 'Scandit Frameworks Shared Parser module'
    s.homepage                = 'https://github.com/Scandit/scandit-datacapture-frameworks-parser'
    s.license                 = { :type => 'Apache-2.0' , :text => 'Licensed under the Apache License, Version 2.0 (the "License");' }
    s.author                  = { 'Scandit' => 'support@scandit.com' }
    s.platforms               = { :ios => '14.0' }
    s.source                  = { :git => 'https://github.com/Scandit/scandit-datacapture-frameworks-parser.git', :tag => '7.3.2' }
    s.swift_version           = '5.7'
    s.source_files            = 'Sources/**/*.{h,m,swift}'
    s.requires_arc            = true
    s.module_name             = 'ScanditFrameworksParser'
    s.header_dir              = 'ScanditFrameworksParser'

    s.dependency 'scandit-datacapture-frameworks-core', '= 7.3.2'
    s.dependency 'ScanditParser', '= 7.3.2'
end
