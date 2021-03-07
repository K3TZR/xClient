//
//  Modifiers.swift
//  xClient
//
//  Created by Douglas Adams on 3/5/21.
//

import SwiftUI

public struct ClearButton: ViewModifier {
    var text: Binding<String>

    public init(boundText: Binding<String>) {
        self.text = boundText
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.wrappedValue.isEmpty {
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 17, height: 17)
                    .onTapGesture {
                        text.wrappedValue = ""
                    }
            }
        }
    }
}
