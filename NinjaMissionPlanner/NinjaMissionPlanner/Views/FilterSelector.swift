//
//  FilterSelector.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct FilterSelector: View {
    @Binding var filter: MissionFilter

    var body: some View {
        HStack {
            ForEach(MissionFilter.allCases) { option in
                Button(action: {
                    filter = option
                }) {
                    Text(option.displayName)
                        .padding()
                        .background(filter == option ? Color.black : Color.gray.opacity(0.2))
                        .foregroundColor(filter == option ? .white : .black)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical)
    }
}
