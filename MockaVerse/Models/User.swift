import Foundation

// MARK: - User Role Enum
enum UserRole: String, CaseIterable, Codable {
  case admin = "admin"
  case user = "user"
  case viewer = "viewer"
  
  var displayName: String {
    switch self {
    case .admin:
      return "Yönetici"
    case .user:
      return "Kullanıcı"
    case .viewer:
      return "Görüntüleyici"
    }
  }
  
  // Permissions
  var canViewScenarios: Bool { true }
  var canEditScenarios: Bool { self != .viewer }
  var canDeleteScenarios: Bool { self != .viewer }
  var canCreateScenarios: Bool { self != .viewer }
  
  var canViewCustomers: Bool { true }
  var canEditCustomers: Bool { self != .viewer }
  var canDeleteCustomers: Bool { self != .viewer }
  var canCreateCustomers: Bool { self != .viewer }
  
  var canViewChannels: Bool { self == .admin }
  var canEditChannels: Bool { self == .admin }
  var canDeleteChannels: Bool { self == .admin }
  var canCreateChannels: Bool { self == .admin }
  
  var canViewUsers: Bool { self == .admin }
  var canEditUsers: Bool { self == .admin }
  var canDeleteUsers: Bool { self == .admin }
  var canCreateUsers: Bool { self == .admin }
  
  var availableTabs: [AppTab] {
    switch self {
    case .admin:
      return [.scenarios, .customers, .channels, .users, .profile]
    case .user:
      return [.scenarios, .customers, .profile]
    case .viewer:
      return [.scenarios, .customers, .profile]
    }
  }
}

// MARK: - App Tabs Enum
enum AppTab: String, CaseIterable {
  case scenarios = "scenarios"
  case customers = "customers"
  case channels = "channels"
  case users = "users"
  case profile = "profile"
  
  var title: String {
    switch self {
    case .scenarios:
      return "Senaryolar"
    case .customers:
      return "Müşteriler"
    case .channels:
      return "Kanallar"
    case .users:
      return "Kullanıcılar"
    case .profile:
      return "Profil"
    }
  }
  
  var iconName: String {
    switch self {
    case .scenarios:
      return "doc.text"
    case .customers:
      return "person.2"
    case .channels:
      return "antenna.radiowaves.left.and.right"
    case .users:
      return "person.3"
    case .profile:
      return "person.circle"
    }
  }
}

// MARK: - User Model
struct User: Codable, Identifiable {
  let id: String
  let username: String
  let name: String
  let userCode: String
  let email: String?
  let role: UserRole
  let isActive: Bool
  let createdAt: Date
  let lastLoginAt: Date?
  
  init(id: String = UUID().uuidString, 
       username: String,
       name: String,
       userCode: String,
       email: String? = nil, 
       role: UserRole, 
       isActive: Bool = true, 
       createdAt: Date = Date(), 
       lastLoginAt: Date? = nil) {
    self.id = id
    self.username = username
    self.name = name
    self.userCode = userCode
    self.email = email
    self.role = role
    self.isActive = isActive
    self.createdAt = createdAt
    self.lastLoginAt = lastLoginAt
  }
}



// MARK: - Sample Users
extension User {
  static let sampleUsers: [User] = [
    User(
      username: "admin",
      name: "Sistem Yöneticisi",
      userCode: "ADM001",
      email: "admin@mockaverse.com",
      role: .admin,
      lastLoginAt: Date()
    ),
    User(
      username: "huseyiny",
      name: "Hüseyin Yıldırım",
      userCode: "USR001",
      email: "huseyin@mockaverse.com", 
      role: .user,
      lastLoginAt: Date().addingTimeInterval(-3600)
    ),
    User(
      username: "viewer",
      name: "Görüntüleyici Kullanıcı",
      userCode: "VWR001",
      email: "viewer@mockaverse.com",
      role: .viewer,
      lastLoginAt: Date().addingTimeInterval(-7200)
    )
  ]
}