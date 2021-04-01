### xClient [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://en.wikipedia.org/wiki/MIT_License)

#### Swift Package for use in a macOS / iOS Client. It provides the "boilerplate" capabilites needed by an app communicating with a Flex 6000 radio using xLib6000.

##### Built on:

*  macOS 11.2.2
*  Xcode 12.4 (12D4e)
*  Swift 5.3 / SwiftUI

##### Runs on:
* macOS 11 and higher
* iOS 14 and higher

##### Builds
This is a Swift Package, no executables are created.

##### Comments / Questions
Please send any bugs / comments / questions to support@k3tzr.net

##### Credits
[CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket)

[xLib6000](https://github.com/K3TZR/xLib6000.git)

[SwiftyUserDefaults](https://github.com/sunshinejr/SwiftyUserDefaults.git)

[XCGLogger](https://github.com/DaveWoodCom/XCGLogger.git)

[JWTDecode](https://github.com/auth0/JWTDecode.swift.git)

##### Other software
[![xSDR6000](https://img.shields.io/badge/K3TZR-xSDR6000-informational)]( https://github.com/K3TZR/xSDR6000) A SmartSDR-like client for the Mac.   
[![DL3LSM](https://img.shields.io/badge/DL3LSM-xDAX,_xCAT,_xKey-informational)](https://dl3lsm.blogspot.com) Mac versions of DAX and/or CAT and a Remote CW Keyer.  
[![W6OP](https://img.shields.io/badge/W6OP-xVoiceKeyer,_xCW-informational)](https://w6op.com) A Mac-based Voice Keyer and a CW Keyer.  

---
##### 1.2.5 Release Notes
* minor changes to logging parameters

##### 1.2.4 Release Notes
* renamed defaultConnection to defaultNonGuiConnection
* added color to LogView
* added timeout to synchronousDataTask in AuthManager
* improved handling of fatal errors
* corrected loadPickerPickets and chooseDefault
* removed unused code

##### 1.2.3 Release Notes
* changed UIImage / NSImage to SwiftUI Image
* changed UIColor / NSColor to SwiftUI Color
* corrected default Station name

##### 1.2.2 Release Notes
* removed LoggerViewIsOpen property
* put PickerPackets change on main queue
* added a timeout to the synchronousDataTask (guard against non response by Smartlink)

##### 1.2.1 Release Notes
* made PickerPackets @Published

##### 1.2.0 Release Notes
* code cleanup
* elimination of sub view folder
* multiple methods renamed
* verified compilation for both iOS and macOS

##### 1.1.0 Release Notes
* rename Logger to LogManager
* total rewrite of Auth0 authentication (AuthManager)
* added defaultAction and cancelAction to multiple buttons
* changes throughout to support AuthManager usage
* added smartlinkAuthenticationView
* bug fixes throughout

##### 1.0.0 Release Notes
* initial release after conversion from xClientMac
