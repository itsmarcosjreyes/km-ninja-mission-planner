//
//  FilterSelectionScreen.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI

struct FilterSelectionScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedFilter: MissionFilter
    @Environment(\.dismiss) var dismiss

    // MARK: - UI

    var body: some View {
        NavigationStack {
            List {
                ForEach(MissionFilter.allCases) { filter in
                    FilterOptionButton(label: filter.displayName) {
                        selectedFilter = filter
                        dismiss()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(NinjaConstants.Strings.selectFilter.value)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        CloseIconImage()
                    }
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
}

struct FilterSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var filter: MissionFilter = .all
        FilterSelectionScreen(selectedFilter: $filter)
    }
}
