//
//  ViewController.swift
//  WIFI_Captive
//
//  Created by Sgmedical on 2016/12/16.
//  Copyright © 2016年 Sgmedical. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        printRetrieveWifiNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func printRetrieveWifiNetwork(){
        
        let interfaces = CNCopySupportedInterfaces()! as CFArray
        if interfaces == nil {
            return
        }
        
        print("interfaces: \(interfaces)")
        
        for i in 0..<CFArrayGetCount(interfaces) {
            guard let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i) else {
                return
            }
            
            //let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
            guard let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(interfaceName)" as CFString) else {
                return
            }
            
            guard let interfaceData = unsafeInterfaceData as Dictionary! else {
                return
            }
            
            print("SSID: \(interfaceData["SSID"]) as! String")
            print("BSSID: \(interfaceData["BSSID"]) as! String")
            
        }
    }
}

