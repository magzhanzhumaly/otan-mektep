# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'otan-mektep' do
  use_frameworks!

#  pod 'AlamofireObjectMapper', '5.1.0'
#  pod 'Alamofire', '4.7.3'
#  pod 'Firebase/Messaging', '6.31.1'
  pod 'DropDown'
  pod 'FirebaseAuth'
  
  target 'otan-mektepTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'otan-mektepUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

#post_install do |installer|
#    installer.pods_project.build_configurations.each do |config|
#      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#      # Avoids build error 'Building for simulator but trying to use Realm file meant for device'
#    end
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            #config.build_settings['SWIFT_VERSION'] = '4.0'
#            # Avoids issue: some old libs are written in swift 4 and can't be migrated to swift 5
#        end
#    end
#    
#    installer.generated_projects.each do |project|
#      project.targets.each do |target|
#        target.build_configurations.each do |config|
#          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
#        end
#      end
#    end
#end
