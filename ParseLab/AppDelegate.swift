//
//  AppDelegate.swift
//  ParseLab
//
//  Created by Roger Hu on 9/25/17.
//  Copyright © 2017 Roger Hu. All rights reserved.
//

import Parse
import ParseLiveQuery
import UIKit

extension Notification.Name {
    static let ParseWillSendURLRequestNotification = Notification.Name(rawValue: "PFNetworkWillSendURLRequestNotification")
    static let ParseDidReceiveURLResponseNotification = Notification.Name(rawValue: "PFNetworkDidReceiveURLResponseNotification")
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Parse.setLogLevel(PFLogLevel.debug)
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) in
            configuration.applicationId = "CodePath-Parse"
            configuration.server = "http://45.79.67.127:1337/parse/"
            configuration.clientKey = nil
        }))

        Message.registerSubclass()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveWillSendURLRequestNotification), name: Notification.Name.ParseWillSendURLRequestNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDidReceiveURLResponseNotification), name: Notification.Name.ParseDidReceiveURLResponseNotification, object: nil)

        return true
    }

    @objc func receiveWillSendURLRequestNotification(notification: Notification) {
        let request = notification.userInfo?[PFNetworkNotificationURLRequestUserInfoKey];

        if let nsRequest = request as? NSMutableURLRequest {
            print("URL: \(nsRequest.url?.absoluteString)")
        }
    }

    @objc func receiveDidReceiveURLResponseNotification(notification: Notification) {
        let response = notification.userInfo?[PFNetworkNotificationURLResponseUserInfoKey];
        let responseBody = notification.userInfo?[PFNetworkNotificationURLResponseBodyUserInfoKey]

        if let response = response as? HTTPURLResponse {
            print ("Status Code: \(response.statusCode)")
        } else {
            return
        }

        if let responseBody = responseBody as? String {
            print ("Response Body: \(responseBody)")
        }

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

