//
//  GroupHeader.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct GroupHeader: View {
    let category: MissionCategory
    let expanded: Bool
    let groupColor: Color
    let onToggle: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                onToggle()
            }
        }) {
            HStack {
                Text(category.displayName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: NinjaConstants.Images.chevronDownIcon.name)
                    .rotationEffect(.degrees(expanded ? 180 : 0))
                    .foregroundColor(.gray)
                    .animation(.easeInOut(duration: 0.2), value: expanded)
            }
            .padding(.vertical, 4)
        }
        .contentShape(Rectangle())
    }
}
