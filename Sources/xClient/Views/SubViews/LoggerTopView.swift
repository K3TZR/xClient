//
//  LoggerTopView.swift
//  xClient
//
//  Created by Douglas Adams on 12/19/20.
//

import SwiftUI

struct LoggerTopView: View {
    @EnvironmentObject var logger: Logger
    
    var body: some View {
        #if os(macOS)
        HStack {
            Picker("Show Level", selection: $logger.level) {
                ForEach(Logger.LogLevel.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.frame(width: 175)

            Spacer()
            Picker("Filter by", selection: $logger.filterBy) {
                ForEach(Logger.LogFilter.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.frame(width: 175)

            TextField("Filter text", text: $logger.filterByText)
                .frame(maxWidth: 300, alignment: .leading)
                .modifier(ClearButton(boundText: $logger.filterByText))
//                .background(Color(.separatorColor))

            Spacer()
            Toggle(isOn: $logger.showTimestamps) { Text("Show Timestamps") }
        }
        #elseif os(iOS)
        HStack {
            Text("Show Level")
            Picker(logger.level.rawValue, selection: $logger.level) {
                ForEach(Logger.LogLevel.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.frame(width: 175)

            Spacer()
            Text("Filter by")
            Picker(logger.filterBy.rawValue, selection: $logger.filterBy) {
                ForEach(Logger.LogFilter.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.frame(width: 175)

            TextField("Filter text", text: $logger.filterByText)
                .frame(maxWidth: 300, alignment: .leading)
                .modifier(ClearButton(boundText: $logger.filterByText))
//                .background(Color(.separator))

            Spacer()
            Toggle(isOn: $logger.showTimestamps) { Text("Show Timestamps") }
        }
        .pickerStyle(MenuPickerStyle())
        #endif
    }
}

struct LoggerTopView_Previews: PreviewProvider {
    static var previews: some View {
        LoggerTopView()
            .environmentObject(Logger.sharedInstance)
    }
}
