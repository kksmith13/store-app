//
//  AppDelegate.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initOnFirstLaunch()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = MainNavigationController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func initOnFirstLaunch() {
        let defaults = UserDefaults.standard
        //defaults. TODO: Handle last updated
        //Handle first time launch settings
        if !defaults.bool(forKey: "HasLaunchedOnce"){
            defaults.setValue("#004078", forKey: "primaryColor")
            defaults.setValue("#FFF708", forKey: "secondaryColor")
            defaults.setValue("0", forKey: "icon")
            defaults.set(true, forKey: "HasLaunchedOnce")
            defaults.synchronize()
        }
    }
    
    // MARK: - utility routines
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    // MARK: - Core Data stack (generic)
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "UserInfo", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("UserInfo").appendingPathExtension("User.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let dict : [String : Any] = [NSLocalizedDescriptionKey        : "Failed to initialize the application's saved data" as NSString,
                                         NSLocalizedFailureReasonErrorKey : "There was an error creating or loading the application's saved data." as NSString,
                                         NSUnderlyingErrorKey             : error as NSError]
            
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            fatalError("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }
        
        return coordinator
    }()
    
    // MARK: - Core Data stack (iOS 9)
    @available(iOS 9.0, *)
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data stack (iOS 10)
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserInfo")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError?
            {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        )
        
        return container
    }()
    
    // MARK: - Core Data context
    lazy var databaseContext : NSManagedObjectContext = {
        if #available(iOS 10.0, *) {
            return self.persistentContainer.viewContext
        } else {
            return self.managedObjectContext
        }
    }()
    
    // MARK: - Core Data save
    func saveContext () {
        do {
            if databaseContext.hasChanges {
                try databaseContext.save()
            }
        } catch {
            let nserror = error as NSError
            
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

