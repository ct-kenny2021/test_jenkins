# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
inhibit_all_warnings!
target 'TestSupportEnvDemo' do

  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
   project 'TestSupportEnvDemo.xcodeproj',  {
      		'PROD' => :release,
      		'PRE' => :debug,
      		'TEST' => :debug,
      		'DEV' => :debug,
    	}
	pod 'Masonry'
	pod 'AFNetworking'
    	pod 'JPush'
  # Pods for TestSupportEnvDemo

  target 'TestSupportEnvDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TestSupportEnvDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
