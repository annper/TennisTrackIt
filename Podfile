workspace 'TennisTrackIt'
use_frameworks!
inhibit_all_warnings!
platform :ios, '9.0'
install! 'cocoapods', :deterministic_uuids => false

def all_pods
  pod 'SwiftyJSON'
  pod 'ObjectMapper', '~> 3.1'
  pod 'TPKeyboardAvoiding'
end

target 'TennisTrackIt [Development]' do

  all_pods

end

target 'TennisTrackIt [Enterprise]' do

  all_pods

end
