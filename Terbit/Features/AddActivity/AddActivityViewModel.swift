//
//  AddActivityViewModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import Foundation
import Observation

enum SortOption: String, CaseIterable, Identifiable {
    case title
    case duration

    var id: String { self.rawValue }

    var label: String {
        switch self {
        case .title: return "Sort by Title"
        case .duration: return "Sort by Duration"
        }
    }
}

enum CategoryFilter: String, CaseIterable, Identifiable {
    case all
    case physical
    case mindfulness
    case social
    case screentime

    var id: String { self.rawValue }

    var label: String {
        switch self {
        case .all: return "all"
        case .physical: return "physical"
        case .mindfulness: return "mindfullness"
        case .social: return "social"
        case .screentime: return "screentime"
        }
    }
}



@MainActor
class AddActivityViewModel: ObservableObject {
    @Published var allActivities: [ActivityModel] = []
    @Published var filteredActivities: [ActivityModel] = []
    @Published var searchText: String = ""
    @Published var selectedSortOption: SortOption = .title
    @Published var selectedCategory: CategoryFilter = .all
    
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
            allActivities = decoded
            filteredActivities = decoded
        } catch {
            print("Failed to load JSON: \(error)")
        }
    }

    func updateSearchResults() {
        var results = allActivities
        
        // search by text
        if !searchText.isEmpty {
            results = results.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.desc.localizedCaseInsensitiveContains(searchText)
            }
        }

        // by category
        if selectedCategory != .all {
            results = results.filter { $0.category.lowercased() == selectedCategory.rawValue }
        }
        
        // Sort
        switch selectedSortOption {
        case .title:
            results.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
        case .duration:
            results.sort { $0.duration < $1.duration }
        }

        self.filteredActivities = results
    }
}



