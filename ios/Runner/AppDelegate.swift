import UIKit
import Flutter
import Firebase
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    //    private let linkStreamHandler = LinkStreamHandler()
    private var methodChannel: FlutterMethodChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let controller = window.rootViewController as! FlutterViewController
        methodChannel = FlutterMethodChannel(name: "deeplink_channel", binaryMessenger: controller.binaryMessenger)
        
        methodChannel?.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) in
            guard call.method == "initialLink" else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(url.absoluteString)
        })
        return super.application(app, open: url)
    }
    
}
    
    
    

class LinkStreamHandler: NSObject , FlutterStreamHandler {
  
  var eventSink: FlutterEventSink?
  
  // links will be added to this queue until the sink is ready to process them
  var queuedLinks = [String]()
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    queuedLinks.forEach({ events($0) })
    queuedLinks.removeAll()
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }
  
  func handleLink(_ link: String) -> Bool {
    guard let eventSink = eventSink else {
      queuedLinks.append(link)
      return false
    }
    eventSink(link)
    return true
  }
}
