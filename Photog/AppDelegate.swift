//
//  AppDelegate.swift
//  Photog
//
//  Created by Dhiraj Laddha on 17/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupParse()
        self.setUpAppearance()
        self.window=UIWindow(frame: UIScreen.mainScreen().bounds)
      
        var navigationController=UINavigationController()
        var startViewController=StartViewController(nibName: "StartViewController" ,bundle:nil)
        
        if PFUser.currentUser() == nil
        {
            navigationController.viewControllers=[startViewController]
        }
        else
        {
            println("we have a user")
            var tabBar = TabBarController()
            navigationController.viewControllers = [startViewController ,tabBar]
            
        }

   //     var viewController=UIViewController()
   //     viewController.view.backgroundColor=UIColor.magentaColor()
        
        self.window!.rootViewController=navigationController
        self.window!.makeKeyAndVisible()
       
        
        
        return true
    }
    
    func setupParse() {
        Parse.setApplicationId("rqV5n9G6hEnz3M3yJJ1gfPZQwAbO5GFzePrpqv9H", clientKey: "5vZJgYvkHdLDymfvzjZNkGQ7o53Ie5oalexDPfxp")
        
//        var testObject = PFObject(className: "TestObject1")
//        testObject["foo"] = "bar"
//        testObject.save()

        
    }
    
    func setUpAppearance()
    {
    
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UINavigationBar.appearance().barTintColor=UIColor.blackColor();
        UINavigationBar.appearance().tintColor=UIColor.whiteColor();
        
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().selectionIndicatorImage = UIImage(named: "SelectedTabBackground")
        
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

