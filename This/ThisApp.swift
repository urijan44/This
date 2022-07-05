//
//  ThisApp.swift
//  This
//
//  Created by hoseung Lee on 2022/07/05.
//

import SwiftUI

@main
struct ThisApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          MovieSearchView(configuration: .init(useCase: MockMovieSearchUseCase()))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
