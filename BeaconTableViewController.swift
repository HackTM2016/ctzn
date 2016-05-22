//
//  BeaconTableViewController.swift
//  CTZN
//
//  Created by Dragos Victor Damian on 21/05/16.
//  Copyright © 2016 Dragos Victor Damian. All rights reserved.

import Foundation
import UIKit
import CoreLocation

class BeaconTableViewController : UITableViewController{
    
    @IBOutlet var beaconTableView: UITableView!

    var beacons : Array<CLBeacon> = []
    
    override func viewDidLoad() {
       NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BeaconTableViewController.updateView(_:)), name: "updateBeaconTableView", object: nil)
        //listen for notifications with selector updateView
    }
    
    
    func updateView(note: NSNotification!){
        beacons = note.object! as! Array<CLBeacon>
        beaconTableView.reloadData() //update table data
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        debugPrint(beacons, separator: " , ", terminator: "")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("beaconCell", forIndexPath: indexPath) as UITableViewCell

        let major = beacons[indexPath.row].major as NSNumber
        var majorString = major.stringValue
        
        let minor = beacons[indexPath.row].minor as NSNumber
        var minorString = minor.stringValue
        
        let proximity = beacons[indexPath.row].proximity
        var proximityString = String()
        
        let accuracy = String(format: "%.2f", beacons[indexPath.row].accuracy)
        
        switch proximity
        {
            case .Near:
                proximityString = "Near"
            case .Immediate:
                proximityString = "Immediate"
            case .Far:
                proximityString = "Far"
            case .Unknown:
                proximityString = "Unknown"
        }

        cell.textLabel?.text = "Major: \(majorString) Minor: \(minorString) Proximity: \(proximityString) Accuracy: \(accuracy)m"
        
        
        //display beacon values in cell text label
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Beacons in range"
    }

}
