//
//  VoiceNotifications.swift
//  CTZN
//
//  Created by Dragos Victor Damian on 22/05/16.
//  Copyright © 2016 NestHackers. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class VoiceNotifications: UIViewController, CLLocationManagerDelegate{
    let speechSynthesizer = AVSpeechSynthesizer()
    let locationManager = CLLocationManager()
    let Table48A = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "20CAE8A0-A9CF-11E3-A5E2-0800200C9A66")!, identifier: "Table48A")
    //define region for monitoring
    var window: UIWindow?
    var enteredRegion = false
    var beacons = []
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        locationManager.requestAlwaysAuthorization() //request permission for location updates
        locationManager.delegate = self
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil))
        //set notification settings
        
        return true
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
            
            var text = "Haide să vorbim!"
            
            if enteredRegion {
                text = "Bun venit la masa 48A!"
            }
            
            let utterance = AVSpeechUtterance(string: text)
            
            // set speaker language
            utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speakUtterance(utterance)
            
           
            
        case .Outside:
            
            var text = "De ce nu eşti aici?"
            
            if !enteredRegion {
                text = "Stai! Nu pleca!"
            }
            let utterance = AVSpeechUtterance(string: text)
            
            // set speaker language
            utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speakUtterance(utterance)
            
           
            
        }
    }

    
    @IBOutlet weak var assistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assistButton.layer.cornerRadius = 30;
        assistButton.layer.borderColor = UIColor.clearColor().CGColor;
    }
    
    // This is the action called when the user presses the button.
    @IBAction func speak(sender: AnyObject) {
        let string = "Asistență vocală activată!"
        let utterance = AVSpeechUtterance(string: string)
        
        // set speaker language
        utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
    }
    
    // Called before speaking an utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        print("About to say '\(utterance.speechString)'");
    }
    
    // Called when the synthesizer is finished speaking the utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        print("Finished saying '\(utterance.speechString)");
    }
    
    // This method is called before speaking each word in the utterance.
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let startIndex = utterance.speechString.startIndex.advancedBy(characterRange.location)
        let endIndex = startIndex.advancedBy(characterRange.length)
        print("Will speak the word '\(utterance.speechString.substringWithRange(startIndex..<endIndex))'");
    }
}