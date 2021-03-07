//
//  LoggerListView.swift
//  xClient
//
//  Created by Douglas Adams on 12/19/20.
//

import SwiftUI

struct LoggerListView: View {
    @EnvironmentObject var logger: Logger
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading) {
                ForEach(logger.logLines) { line in
                    Text(line.text)
                        .font(.system(size: CGFloat(logger.fontSize), weight: .regular, design: .monospaced))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LoggerListView_Previews: PreviewProvider {
    static var previews: some View {
        LoggerListView()
            .environmentObject(Logger.sharedInstance)
    }
}
