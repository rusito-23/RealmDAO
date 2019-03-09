//
//  SwiftyBeaverExtension.swift
//  RealmDAO
//
//  Created by Igor on 09/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import SwiftyBeaver


// direct access to the logger across the app
let logger = SwiftyBeaver.self


extension SwiftyBeaver {
  
  static func setUpConsole() {
    let console = ConsoleDestination()
    
    console.levelColor.verbose = "⚪️ "
    console.levelColor.debug = "☑️ "
    console.levelColor.info = "🔵 "
    console.levelColor.warning = "🔶 "
    console.levelColor.error = "🔴 "
    
    logger.addDestination(console)
    
  }
  
}
