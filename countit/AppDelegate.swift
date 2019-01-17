//
//  AppDelegate.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        let isSQLDatabase = ProcessInfo.processInfo.arguments.contains("test") ? false : true
        
        let context = CoreDataConfig.getCoreDataContext(isSQLDatabase: isSQLDatabase)
        
        let clock = Clock()
        let calendar = Calendar.autoupdatingCurrent
        
        let activityRepository = ActivityRepositoryImpl(context: context)
        let activityService = ActivityServiceImpl(activityRepository: activityRepository, clock: clock, calendar: calendar)
        let itemRepository = ItemRepositoryImpl(context: context)
        let itemService = ItemServiceImpl(activityService: activityService, itemRepository: itemRepository, clock: clock)
        
        let viewResolver = ViewResolver()
        let controllerResolver = ControllerResolver()
        controllerResolver.add(controller: ProgressTableController(
            controllerResolver, viewResolver, itemService, activityService), called: ControllerType.PROGRESS_TABLE_CONTROLLER)
        controllerResolver.add(controller: ItemFormController(controllerResolver, viewResolver, itemService), called: ControllerType.ITEM_FORM_CONTROLLER)
        controllerResolver.add(controller: UINavigationController(rootViewController: controllerResolver.get(ControllerType.PROGRESS_TABLE_CONTROLLER)!), called: ControllerType.PRIMARY_NAV_CONTROLLER)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = controllerResolver.get(ControllerType.PRIMARY_NAV_CONTROLLER)
        window!.makeKeyAndVisible()
        return true
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
}

