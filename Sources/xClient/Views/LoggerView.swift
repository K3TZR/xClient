//
//  LoggerView.swift
//  xClient
//
//  Created by Douglas Adams on 10/10/20.
//

import SwiftUI

/// A View to display the contents of the app's log
///
public struct LoggerView: View {
    @EnvironmentObject var logger : LogManager
    
    public init() {}
    
    public var body: some View {
        
        VStack {
            LoggerTopView()

            #if os(macOS)
            Divider().frame(height: 2).background(Color(.separatorColor))
            LoggerListView()
            Divider().frame(height: 2).background(Color(.separatorColor))
            #elseif os(iOS)
            Divider().frame(height: 2).background(Color(.separator))
            LoggerListView()
            Divider().frame(height: 2).background(Color(.separator))
            #endif

            LoggerBottomView()
        }
        .frame(minWidth: 700)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .onAppear() {
            logger.loadDefaultLog()
        }
        .sheet(isPresented: $logger.showLogPicker) {
            LogPickerView().environmentObject(logger)
        }
    }
}

public struct LoggerView_Previews: PreviewProvider {
    public static var previews: some View {
        LoggerView()
            .environmentObject( LogManager.sharedInstance)
    }
}
