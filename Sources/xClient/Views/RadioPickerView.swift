//
//  RadioPickerView.swift
//  xClient
//
//  Created by Douglas Adams on 8/15/20.
//

import SwiftUI

/// A View to allow the user to select a Radio / Station for connection
///
public struct RadioPickerView: View {
    @EnvironmentObject var radioManager: RadioManager
    
    public init() {}
    
    public var body: some View {
        VStack {
            VStack (spacing: 20) {
                ForEach(radioManager.pickerMessages, id: \.self) { message in
                    Text(message).foregroundColor(.red)
                }
            }.padding(.bottom, 20)
            
            Text(radioManager.pickerHeading).font(.largeTitle)
            
            Divider()
            RadioPickerListView()
            
            Divider()
            RadioPickerBottomView()
        }
        .padding()
        .frame(minWidth: 550)
        .onDisappear(perform: {radioManager.connect(to: radioManager.pickerSelection)})
    }
}

public struct RadioPickerView_Previews: PreviewProvider {    
    public static var previews: some View {
        RadioPickerView()
            .environmentObject(RadioManager(delegate: MockRadioManagerDelegate() ))
    }
}
