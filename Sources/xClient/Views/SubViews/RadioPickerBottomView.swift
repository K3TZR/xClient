//
//  RadioPickerBottomView.swift
//  xClient
//
//  Created by Douglas Adams on 8/13/20.
//

import SwiftUI

/// Picker buttons to Test, Close or Select
///
struct RadioPickerBottomView: View {
    @EnvironmentObject var radioManager : RadioManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(spacing: 40){
            TestButtonView()
            Button("Cancel") {
                radioManager.pickerSelection = nil
                presentationMode.wrappedValue.dismiss()
            }
            .keyboardShortcut(.cancelAction)

            Button("Connect") {
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(radioManager.pickerSelection == nil)
            .keyboardShortcut(.defaultAction)
        }
    }
}

struct RadioPickerBottomView_Previews: PreviewProvider {
    static var previews: some View {
        RadioPickerBottomView()
            .environmentObject(RadioManager(delegate: MockRadioManagerDelegate()))
    }
}
