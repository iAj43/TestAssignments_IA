//
//  HomeViewModel.swift
//  TestAssignment_SwiftUI_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import Foundation

struct CharacterOccurrenceData: Hashable {
    let character: String
    let count: Int
}

struct ViewModelPublishers {
    var mealTypesDetailData: [MealTypesDetailData]?
    var filteredList: [ListData] = []
    var searchText: String = ""
    var selection: Int = 0
    var showBottomSheet: Bool = false
    var showAlert: Bool = false
    var errorMessage: String = ""
}

class HomeViewModel: ObservableObject {
    
    @Published var viewModelPublishers = ViewModelPublishers()
    private var requestManager: FileReaderProtocol = FileReader()
    private var dictionary: [CharacterOccurrenceData] = []
    
    func getMealData() {
        do {
            let response: MealTypesData = try requestManager.loadDataFrom(file: "meal_types", type: "json")
            viewModelPublishers.mealTypesDetailData = response.mealTypes
            viewModelPublishers.showAlert = false
            viewModelPublishers.errorMessage = ""
        } catch let error {
            viewModelPublishers.showAlert = true
            viewModelPublishers.errorMessage = error.localizedDescription
        }
    }
    
    func filterListData() {
        if viewModelPublishers.searchText.isEmpty {
            viewModelPublishers.filteredList = viewModelPublishers.mealTypesDetailData?[viewModelPublishers.selection].listData ?? []
        } else {
            viewModelPublishers.filteredList = viewModelPublishers.mealTypesDetailData?[viewModelPublishers.selection].listData?.filter { meal in
                meal.title!.localizedCaseInsensitiveContains(viewModelPublishers.searchText.lowercased())
            } ?? []
        }
    }
    
    func topThreeCharacters(in array: [String]) -> [CharacterOccurrenceData] {
        var charCount: [Character: Int] = [:]
        for string in array {
            for char in string {
                if char != " " {
                    charCount[char, default: 0] += 1
                }
            }
        }
        let sortedCharCount = charCount.sorted { $0.value > $1.value }
        let topThree = sortedCharCount.prefix(3).map { CharacterOccurrenceData(character: String($0.key), count: $0.value) }
        return topThree
    }
}
