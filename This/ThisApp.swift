//
//  ThisApp.swift
//  This
//
//  Created by hoseung Lee on 2022/07/05.
//

import SwiftUI

@main
struct ThisApp: App {
  private let diContainer = DependencyInjectionContainer()
  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      diContainer.makeMovieSearchView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
