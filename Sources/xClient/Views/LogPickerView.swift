//
//  LogPickerView.swift
//  xClient
//
//  Created by Douglas Adams on 3/4/21.
//

import SwiftUI

public struct LogPickerView: View {
    @EnvironmentObject var logger : LogManager
    @Environment(\.presentationMode) var presentationMode

    @State var selection: Int?

    public init() {}

    public var body: some View {

        VStack {
            Text("Choose a log file").font(.title)

            Divider()

            #if os(macOS)
            List(logger.fileUrls, id: \.id, selection: $selection) { log in
                Text(log.url.lastPathComponent)
            }
            #elseif os(iOS)
            List(logger.fileUrls, id: \.id, selection: $selection) { log in
                Text(log.url.lastPathComponent)
            }
            .environment(\.editMode, .constant(EditMode.active))
            #endif

            Divider()
            HStack(spacing: 80) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }.keyboardShortcut(.cancelAction)

                Button("Select") {
                    presentationMode.wrappedValue.dismiss()
                    logger.loadFile(at: selection)
                }
                .disabled(selection == nil)
                .keyboardShortcut(.defaultAction)
            }
            .frame(alignment: .leading)
        }
        .frame(minHeight: 300)
        .padding(.bottom)
    }
}

struct LogPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LogPickerView().environmentObject(LogManager.sharedInstance)
    }
}
