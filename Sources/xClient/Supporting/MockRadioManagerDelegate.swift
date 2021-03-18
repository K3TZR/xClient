//
//  MockRadioManagerDelegate.swift
//  xClient
//
//  Created by Douglas Adams on 9/5/20.
//

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif
import xLib6000

class MockRadioManagerDelegate: RadioManagerDelegate {
    // ----------------------------------------------------------------------------
    // MARK: - Internal properties
    
    var clientId: String?
    var connectToFirstRadio   = false
    var defaultConnection: String?
    var defaultGuiConnection: String?
    var enableGui             = true
    var smartlinkEmail: String?
    var smartlinkEnabled      = true
    var smartlinkIsLoggedIn   = true
    var smartlinkUserImage: SmartlinkImage?
    var stationName           = "MockStation"

    var activePacket: DiscoveryPacket?
    // ----------------------------------------------------------------------------
    // MARK: - Internal methods
    
    func willConnect() {}
    func willDisconnect() {}
}
