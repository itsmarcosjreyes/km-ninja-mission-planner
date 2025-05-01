//
//  MissionRow.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct MissionRow: View {
    let mission: Mission
    let onMarkDone: (Mission) -> Void
    let onRequestDelete: (Mission) -> Void // Rename for clarity

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(mission.category.color)
                    .frame(width: 12, height: 12)
                if mission.isPastDue {
                    Circle()
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: 18, height: 18)
                }
            }

            Text(mission.name)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)

            if mission.isDone {
                Image(systemName: NinjaConstants.Images.checkmarkFilledIcon.name)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 8)
        .swipeActions(edge: .trailing) {
            // Toggle complete/incomplete
            Button {
                onMarkDone(mission)
            } label: {
                Label(
                    mission.isDone ? NinjaConstants.Strings.markAsNotDone.value : NinjaConstants.Strings.done.value,
                    systemImage: mission.isDone ? NinjaConstants.Images.returnIcon.name : NinjaConstants.Images.checkmarkCircleIcon.name
                )
            }
            .tint(.green)

            // Ask for delete confirmation (do NOT call delete here!)
            Button(role: .destructive) {
                onRequestDelete(mission) // triggers state change only
            } label: {
                Label(NinjaConstants.Strings.delete.value, systemImage: NinjaConstants.Images.trashIcon.name)
            }
        }
    }
}
