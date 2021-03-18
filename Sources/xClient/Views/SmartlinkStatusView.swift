//
//  SmartLinkStatusView.swift
//  xClient
//
//  Created by Douglas Adams on 8/13/20.
//

import SwiftUI

public struct SmartlinkStatusView: View {
    @EnvironmentObject var radioManager : RadioManager
    @Environment(\.presentationMode) var presentationMode
    
    public init() {}
        
    public var body: some View {
        
        VStack(spacing: 20) {
            Text("Smartlink Status").font(.title)
            if radioManager.delegate.smartlinkEnabled {
                EmptyView()
            } else {
                Text("--- Disabled ---").foregroundColor(.red)
            }
            Divider()

//            Spacer()
            HStack (spacing: 20) {
                ZStack {
                    Rectangle()

                    #if os(macOS)
                    Image(nsImage: radioManager.smartlinkImage!)
                        .resizable()
                        .scaledToFill()
                        .background(Color(.controlBackgroundColor))
                    #elseif os(iOS)
                    Image(uiImage: radioManager.smartlinkImage!)
                        .resizable()
                        .scaledToFill()
                        .background(Color(.systemBackground))
                    #endif
                }
                .frame(width: 60, height: 60)
                .cornerRadius(16)

                VStack (alignment: .leading, spacing: 10) {
                    Text("Name").bold()
                    Text("Callsign").bold()
                    Text("Email").bold()
                }
                .frame(width: 70, alignment: .leading)

                VStack (alignment: .leading, spacing: 10) {
                    Text(radioManager.smartlinkName)
                    Text(radioManager.smartlinkCallsign)
                    Text(radioManager.delegate.smartlinkEmail ?? "")
                }
                .frame(width: 200, alignment: .leading)
            }
//            Spacer()
            
            Divider()
            HStack(spacing: 60) {
                Button(radioManager.delegate.smartlinkEnabled ? "Disable" : "Enable") {
                    radioManager.smartlinkEnabledToggle()
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Force Login") {
                    radioManager.smartlinkForceLogin()
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }.keyboardShortcut(.defaultAction)
            }
        }
        .padding()
    }
}

struct SmartLinkView_Previews: PreviewProvider {
    static var previews: some View {
        SmartlinkStatusView()
            .environmentObject(RadioManager(delegate: MockRadioManagerDelegate()))
    }
}
