//
//  AppDelegate.swift
//  CryptoCurBar
//
//  Created by Gerben de Graaf on 13/01/2018.
//  Copyright © 2018 Gerben de Graaf. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
//    @IBOutlet weak var statusMenu: NSMenu!
//    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
//    @IBAction func quitClicked(_ sender: NSMenuItem) {
//        NSApplication.shared.terminate(self)
//    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        // Insert code here to initialize your application
//        statusItem.title = "CryptoCurrencyBar"
//
//        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
//        icon?.isTemplate = true // best for dark mode
//        statusItem.image = icon
//        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
