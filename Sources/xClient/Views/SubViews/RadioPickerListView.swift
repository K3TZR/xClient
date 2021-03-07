//
//  RadioPickerListView.swift
//  xClient
//
//  Created by Douglas Adams on 8/13/20.
//

import SwiftUI

/// Display a List of available radios / stations
///
struct RadioPickerListView : View {
    @EnvironmentObject var radioManager : RadioManager
    
    var body: some View {
        
        VStack (alignment: .leading) {
            ListHeader()
            Divider()
            if radioManager.pickerPackets.count == 0 {
                EmptyList()
            } else {
                PopulatedList()
            }
        }
        .frame(minHeight: 200)
    }
}

struct ListHeader: View {
    var body: some View {
        HStack {
            #if os(macOS)
            Text("").frame(width: 8)
            #elseif os(iOS)
            Text("").frame(width: 25)
            #endif
            Text("Type").frame(width: 130, alignment: .leading)
            Text("Name").frame(width: 130, alignment: .leading)
            Text("Status").frame(width: 130, alignment: .leading)
            Text("Station(s)").frame(width: 130, alignment: .leading)
        }
    }
}

struct EmptyList: View {
    @EnvironmentObject var radioManager : RadioManager

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("---------- No \(radioManager.delegate.enableGui ? "Radios" : "Stations") found ----------")
                    .foregroundColor(.red)
                Spacer()
            }
            Spacer()
        }
    }
}

struct PopulatedList: View {
    @EnvironmentObject var radioManager : RadioManager

    var body: some View {
        #if os(macOS)
        let stdColor = Color(.controlTextColor)

        List(radioManager.pickerPackets, id: \.id, selection: $radioManager.pickerSelection) { packet in
            HStack {
                Text(packet.type == .local ? "LOCAL" : "SMARTLINK").frame(width: 130, alignment: .leading)
                Text(packet.nickname).frame(width: 130, alignment: .leading)
                Text(packet.status.rawValue).frame(width: 130, alignment: .leading)
                Text(packet.stations).frame(width: 130, alignment: .leading)
            }
            .foregroundColor( packet.isDefault ? .red : stdColor )
        }
        .frame(alignment: .leading)

        #elseif os(iOS)
        let stdColor = Color(.label)

        List(radioManager.pickerPackets, id: \.id, selection: $radioManager.pickerSelection) { packet in
            HStack {
                Text(packet.type == .local ? "LOCAL" : "SMARTLINK").frame(width: 130, alignment: .leading)
                Text(packet.nickname).frame(width: 130, alignment: .leading)
                Text(packet.status.rawValue).frame(width: 130, alignment: .leading)
                Text(packet.stations).frame(width: 130, alignment: .leading)
            }
            .foregroundColor( packet.isDefault ? .red : stdColor )
        }
        .frame(alignment: .leading)
        .environment(\.editMode, .constant(EditMode.active))
        #endif
    }
}

struct RadioPickerListView_Previews: PreviewProvider {
    static var previews: some View {
        RadioPickerListView()
            .environmentObject(RadioManager(delegate: MockRadioManagerDelegate()))
    }
}
