import SwiftUI

@main
struct MockaVerseApp: App {
  let persistenceController = CoreDataManager.shared
  @StateObject private var authManager = AuthManager.shared

  var body: some Scene {
    WindowGroup {
      Group {
        if authManager.isAuthenticated {
          ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } else {
          LoginView()
        }
      }
    }
  }
}