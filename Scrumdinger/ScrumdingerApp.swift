//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Danielle Abrams on 7/18/23.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
 
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    }
                    catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
