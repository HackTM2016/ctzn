//
//  Notifications.swift
//  CTZN
//
//  Created by Dragos Victor Damian on 21/05/16.
//  Copyright © 2016 Dragos Victor Damian. All rights reserved.
//

import Foundation
import UIKit

class Notifications {
    
    class func display(text: String){
        
        let notification: UILocalNotification = UILocalNotification()
        notification.timeZone = NSTimeZone.defaultTimeZone()
        
        let dateTime = NSDate()
        notification.fireDate = dateTime
        notification.alertBody = text
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
}
