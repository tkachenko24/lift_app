import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        UNUserNotificationCenter.current().delegate = self
        requestNotificationAuthorization()

        if let controller = window?.rootViewController as? FlutterViewController {
            setupMethodChannel(with: controller)
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func setupMethodChannel(with flutterViewController: FlutterViewController) {
    let channel = FlutterMethodChannel(name: "localNotification", binaryMessenger: flutterViewController.binaryMessenger)

    channel.setMethodCallHandler { [weak self] (call, result) in
        if call.method == "sendLocalNotification" {
            if let args = call.arguments as? [String: Any],
               let title = args["title"] as? String,
               let description = args["description"] as? String {
                self?.sendLocalNotification(title: title, description: description)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for 'sendLocalNotification'", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}

    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        }
    }

    func sendLocalNotification(title: String, description: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = description

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: "sendLocalNotification", content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Failure: \(error.localizedDescription)")
        } else {
            print("Success send")
        }
    }
}
}
