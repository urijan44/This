//
//  FilteredListView.swift
//  
//
//  Created by hoseung Lee on 2022/07/18.
//

import SwiftUI

struct FilteredList<Element, FilterKey, RowContent>: View where Element: Identifiable, RowContent: View {
  private let items: [Element]
  private let filterKey: KeyPath<Element, FilterKey>
  private let isIncluded: (FilterKey) -> Bool
  private let rowContent: (Element) -> RowContent

  var body: some View {
    filteredBody
  }

  var filteredBody: some View {
    let filteredItem = items.filter {
      isIncluded($0[keyPath: filterKey])
    }
    return ForEach(filteredItem, id: \.id) { key in
      rowContent(key)
    }
  }

  init(
    _ items: [Element],
    filterBy key: KeyPath<Element, FilterKey>,
    isIncluded: @escaping (FilterKey) -> Bool,
    @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
    self.items = items
    self.filterKey = key
    self.isIncluded = isIncluded
    self.rowContent = rowContent
  }
}
