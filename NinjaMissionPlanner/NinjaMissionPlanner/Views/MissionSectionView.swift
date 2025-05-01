//
//  MissionSectionView.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct MissionSectionView: View {
    let category: MissionCategory
    let isExpanded: Bool
    let missions: [Mission]
    let onToggle: () -> Void
    let onTap: (Mission) -> Void
    let onMarkDone: (Mission) -> Void
    let onDeleteRequest: (Mission) -> Void

    var body: some View {
        Section(
            header: GroupHeader(
                category: category,
                expanded: isExpanded,
                groupColor: category.color,
                onToggle: onToggle
            ),
            footer: GroupFooter(isExpanded: isExpanded, hasMissions: !missions.isEmpty)
        ) {
            if isExpanded {
                ForEach(missions) { mission in
                    MissionRow(
                        mission: mission,
                        onMarkDone: onMarkDone,
                        onRequestDelete: { toDelete in
                            onDeleteRequest(toDelete)
                        }
                    )
                    .onTapGesture {
                        onTap(mission)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func GroupFooter(isExpanded: Bool, hasMissions: Bool) -> some View {
        if isExpanded && hasMissions {
            Text(NinjaConstants.Strings.swipeToDeleteHint.value)
                .font(.footnote)
                .foregroundColor(.gray)
        } else {
            EmptyView()
        }
    }
}
