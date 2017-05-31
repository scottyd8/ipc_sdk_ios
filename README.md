# Worldpay Integrated Payment Client for IOS (Beta)

## Building the Sample Application
The quickest way to see the Integrated Payment Client SDK in action is with the sample application.

### Quick Win
1.  Get the [sample app](http://github.com/worldpayus/ipc_sdk_ios/tree/master/sampleapp) 
2.  Open the project *WorldpaySDKDemo.xcodeproj* in Xcode, build it and run it in the simulator

You can run the app in the iOS simulator (see 'Testing on Simulator' below) and exercise the functions that don't require a device.

### With a Card Reader
You can use the card reader on your iOS device:

3.  Deploy the app on your iOS device
4.  Connect your card reader to your iOS device via bluetooth
5.  Run the app

### Testing on Simulator
You have to switch the framework in the SDK root folder with the one in the simulator-support folder in order to run your app on a simulator.

## Note
The default framework in the SDK folder only supports physical device deployments and is compliant for release builds.

If you wish to debug using simulator support, add the framework provided in sdk/simulator-support. This framework is not compliant with deployments to the app store and must be removed prior to generating a release build.

## More Information
You can find the Getting Started Guide, full documentation of the SDK object library, as well as Application Notes on our [iOS documentation library](https://worldpayus.github.io/ipc_sdk_ios).

### Worldpay Total Developer Resources
For information about getting your sandbox account, and comprehensive information about the Integrated Payment Hub REST API, see our developer resources at http://worldpay.us/developer
