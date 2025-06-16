import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  private init() {}
  
  lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MockaVerse")
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Core Data error: \(error.localizedDescription)")
      }
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return container.viewContext
  }
  
  func save() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        print("Core Data save error: \(error.localizedDescription)")
      }
    }
  }
}