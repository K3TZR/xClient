//
//  GenericAlertView.swift
//  xClient
//
//  Created by Douglas Adams on 12/5/20.
//

#if os(macOS)
import SwiftUI

public struct GenericAlertView: View {
    @EnvironmentObject var radioManager : RadioManager
    @Environment(\.presentationMode) var presentationMode
    
    public init() {}

    public var body: some View {
        
        let params = radioManager.currentAlert
        
        VStack (spacing: 20) {
            Text(params.title).font(.title2)
            
            if params.message == "" {
                EmptyView()
            } else {
                Text(params.message)
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            
            Divider()
            VStack {
                ForEach(params.buttons.indices) { i in
                    let button = params.buttons[i]
                    Button(action: {
                        button.action()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(button.text)
                            .frame(width: 175)
                            .foregroundColor(button.color == nil ? Color(.controlTextColor) : button.color)
                    }
                }.frame(width: 250)
            }
        }.padding()
    }
}

public struct AlertView_Previews: PreviewProvider {
    public static var previews: some View {
        GenericAlertView()
            .environmentObject(RadioManager(delegate: MockRadioManagerDelegate()))
    }
}
#endif
