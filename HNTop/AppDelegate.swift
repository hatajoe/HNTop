//
//  AppDelegate.swift
//  HNTop
//
//  Created by hatanakayusuke on 2/23/16.
//  Copyright © 2016 hatanakayusuke. All rights reserved.
//

import UIKit
import APIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // エンドポイント用のクラスを生成する
        let request = HNTopRequest()
        // WebAPIへのアクセス
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response): // 成功時は、Weather型のデータが取得できる
                let sliced = response.IDList[0..<4]
                for ID in sliced {
                    let r = HNStoryRequest.init(ID: ID)
                    Session.sendRequest(r) { result in
                        switch result {
                        case .Success(let res): // 成功時は、Weather型のデータが取得できる
                            print("ID: \(res.ID)")
                            print("\tAuthor: \(res.Author)")
                            print("\tScore: \(res.Score)")
                            print("\tTime: \(res.Time)")
                            print("\tTitle: \(res.Title)")
                            print("\tUrl: \(res.Url)")
                        case .Failure(let error): // 失敗した場合、NSError型となる
                            print("error: \(error)")
                        }
                    }
                }
            case .Failure(let error): // 失敗した場合、NSError型となる
                print("error: \(error)")
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

