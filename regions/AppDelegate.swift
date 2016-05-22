//
//  AppDelegate.swift
//  CTZN
//
//  Created by Dragos Victor Damian on 21/05/16.
//  Copyright © 2016 Dragos Victor Damian. All rights reserved.

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate{

    var window: UIWindow?
    
    let locationManager = CLLocationManager()
    let Table48A = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "20CAE8A0-A9CF-11E3-A5E2-0800200C9A66")!, identifier: "Table48A")
    //define region for monitoring
    
    var enteredRegion = false
    var beacons = []
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        locationManager.requestAlwaysAuthorization() //request permission for location updates
        locationManager.delegate = self
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil))
        //set notification settings
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
       
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status{
            
        case .AuthorizedAlways:
            
            locationManager.startMonitoringForRegion(Table48A)
            locationManager.startRangingBeaconsInRegion(Table48A)
            locationManager.requestStateForRegion(Table48A)
            
        case .Denied:
            
            let alert = UIAlertController(title: "Warning", message: "You've disabled location update which is required for this app to work. Go to your phone settings and change the permissions.", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
            alert.addAction(alertAction)
            
            self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            
            //display error message if location updates are declined
            
        default:
            print("default case")
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        
        switch state {
            
            case .Unknown:
                print("unknown")
            
            case .Inside:
            
                var text = "Tap here to start coding."
            
                if enteredRegion {
                    text = "Welcome to Table 48A, birthplace of CTZN."
                }
                
                Notifications.display(text)
        
            case .Outside:
          
                var text = "Why aren't you here? :("
            
                if !enteredRegion {
                    text = "Wait! Don't go into the light."
                }
                Notifications.display(text)
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
//            debugPrint(beacons, separator: " , ", terminator: "")
            self.beacons = beacons
            
            NSNotificationCenter.defaultCenter().postNotificationName("updateBeaconTableView", object: self.beacons)
            //send updated beacons array to BeaconTableViewController
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        enteredRegion = true
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        enteredRegion = false
    }
    

}

