import Foundation

// MARK: - Login Credentials
struct LoginCredentials: Codable {
  let username: String
  let password: String
}

// MARK: - Auth Response
struct AuthResponse: Codable {
  let success: Bool
  let token: String?
  let user: User?
  let message: String?
  
  enum CodingKeys: String, CodingKey {
    case success, token, user, message
  }
}