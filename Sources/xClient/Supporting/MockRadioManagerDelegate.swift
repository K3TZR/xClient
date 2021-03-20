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
    var connectToFirstRadioIsEnabled   = false
    var defaultConnection: String?
    var defaultGuiConnection: String?
    var guiIsEnabled             = true
    var smartlinkEmail: String?
    var smartlinkIsEnabled      = true
    var smartlinkIsLoggedIn   = true
    var smartlinkUserImage: SmartlinkImage?
    var stationName           = "MockStation"

    var activePacket: DiscoveryPacket?
    // ----------------------------------------------------------------------------
    // MARK: - Internal methods
    
    func willConnect() {}
    func willDisconnect() {}
}
