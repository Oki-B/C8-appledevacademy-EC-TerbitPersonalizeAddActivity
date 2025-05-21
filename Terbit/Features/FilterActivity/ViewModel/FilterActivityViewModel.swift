//
//  FilterActivityViewModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import Foundation
import Combine
import SwiftUI

enum DurationFilter: String, CaseIterable, Identifiable {
    case twoMin = "2 min"
    case threeToFive = "3–5 min"
    case aboveFive = "5+ min"

    var id: String { rawValue }

//    var displayText: String { rawValue }
    // Duration filter logic
    func durationMatches(_ duration: Int) -> Bool {
        switch self {
        case .twoMin:
            return duration <= 2
        case .threeToFive:
            return (3...5).contains(duration)
        case .aboveFive:
            return duration > 5
        }
    }
}


class FilterActivityViewModel: ObservableObject {
    @Published var selectedCategories: Set<String> = []
    @Published var selectedDuration: DurationFilter?
    
    let allCategories = ["Physical", "Mindfulness", "Social", "ScreenTime"]
    let allDurations: [DurationFilter] = DurationFilter.allCases
    @Published var allActivities: [ActivityModel] = []
    @Published var sortedActivities: [ActivityModel] = []
    
    @Published var searchText: String = ""
    @Published var selectedSortOption: SortOption = .title
    
    init() {
        loadActivities()
    }

    func loadActivities() {
        guard let url = Bundle.main.url(forResource: "activitiesData", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([ActivityModel].self, from: data)
            DispatchQueue.main.async {
                self.allActivities = decoded
                self.updateSearchResults()
            }
        } catch {
            print("Failed to load JSON: \(error)")
        }
    }
    
    // Computed property for filtered activities
    var filteredActivities: [ActivityModel] {
        allActivities.filter { activity in
            let matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(where: {
                activity.category.caseInsensitiveCompare($0) == .orderedSame
            })
            let matchesDuration = selectedDuration == nil || selectedDuration!.durationMatches(activity.duration)
            return matchesCategory && matchesDuration
        }
    }
    
    var resultCount: Int {
        // Replace with real filtered result count logic if needed
        filteredActivities.count
    }
    
    // Toggle category selection (select or deselect if same)
    func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }    }

    // Toggle duration selection (select or deselect if same)
    func toggleDuration(_ duration: DurationFilter) {
        if selectedDuration == duration {
            selectedDuration = nil
        } else {
            selectedDuration = duration
        }
    }
    
    func resetFilters() {
        selectedCategories = []
        selectedDuration = nil
    }
    
    func updateSearchResults() {
        var results = filteredActivities
        
        // search by text
        if !searchText.isEmpty {
            results = results.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.desc.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Sort
        switch selectedSortOption {
        case .title:
            results.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
        case .duration:
            results.sort { $0.duration < $1.duration }
        }

        self.sortedActivities = results
    }

}



