//
//  AppDelegate.swift
//  MidoriTimer
//
//  Created by Andrew Cheberyako on 27.04.2021.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
   
    let window: UIWindow? = nil
    let jsonTest = ParseJSON.shared.self
    let notificationCenter = UNUserNotificationCenter.current()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAutorization()
        notificationCenter.delegate = self
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MidoriTimer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge,]) { granted, Error in
            print("permssion grande \(granted)")
            guard granted else {return}
            self.getNotificationSettings()
        }
    }
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("notification setting: \(settings)")
        }
    }
    func scheduleNotification(notifaicationType: String) {
        
        let content = UNMutableNotificationContent()
        
        content.title = notifaicationType
        content.body = "Я молодец" + notifaicationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let identifire = "local notification"
        
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
//    let date = Date(timeIntervalSinceNow: 3600)
//    let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: Date(timeIntervalSinceNow: 3600))
//    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        completionHandler([.list,.banner,.sound])
    }
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "reminderNotificationId" {
           print("oohhhooo")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController,
                let navigationVC = self.window?.rootViewController as? UINavigationController {
                
                navigationVC.present(conversationVC, animated: true, completion: nil)
                navigationVC.pushViewController(conversationVC, animated: true)
//                jsonTest.loadJson()
//                let arrayTest = jsonTest.test
//                let randomElementArray = arrayTest[randomNomber]
//                conversationVC.noteArrayDate.append(randomElementArray)
            }
            
            
        }
        completionHandler()
    
    }
}

