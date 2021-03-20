//
//  MockLogManagerDelegate.swift
//  xClient
//
//  Created by Douglas Adams on 10/23/20.
//

#if os(macOS)
import AppKit

final class MockLogManagerDelegate: LogManagerDelegate, ObservableObject {
    // ----------------------------------------------------------------------------
    // MARK: - Published properties

    @Published var showLogWindow: Bool = false

    // ----------------------------------------------------------------------------
    // MARK: - Internal properties

    var logWindow: NSWindow? = NSWindow()
}

#elseif os(iOS)
import SwiftUI

final class MockLogManagerDelegate: LogManagerDelegate, ObservableObject {
    // ----------------------------------------------------------------------------
    // MARK: - Published properties

    @Published var logWindowIsOpen: Bool = false
}
#endif
