import SwiftUI

struct ContentView: View {
  @StateObject private var authManager = AuthManager.shared
  @State private var selectedTab = 0
  
  var body: some View {
    Group {
      if authManager.isAuthenticated {
        MainTabView()
          .environmentObject(authManager)
      } else {
        LoginView()
          .environmentObject(authManager)
      }
    }
  }
}

struct MainTabView: View {
  @EnvironmentObject var authManager: AuthManager
  @State private var selectedTab = 0
  
  init() {
    // Tab bar görünümünü özelleştir
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.2, alpha: 1.0) // Yeşil arka plan
    
    // Normal state (seçili olmayan tab)
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.7)
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
      .foregroundColor: UIColor.white.withAlphaComponent(0.7),
      .font: UIFont.systemFont(ofSize: 14, weight: .medium)
    ]
    
    // Selected state (seçili tab)
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font: UIFont.systemFont(ofSize: 14, weight: .bold)
    ]
    
    // Tab bar yüksekliğini artır
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    UITabBar.appearance().itemPositioning = .centered
    UITabBar.appearance().itemSpacing = 8
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      // Scenarios Tab - Available for all roles
      if authManager.hasPermission(for: .viewScenarios) {
        NavigationView {
          ScenarioListView()
        }
        .tabItem {
          Image(systemName: "doc.text")
            .font(.system(size: 24, weight: .medium))
          Text("Senaryolar")
            .font(.system(size: 14, weight: .medium))
        }
        .tag(0)
      }
      
      // Scenario Rule Mapping Tab - Available for all roles
      if authManager.hasPermission(for: .viewScenarios) {
        NavigationView {
          ScenarioRuleMappingView()
        }
        .tabItem {
          Image(systemName: "link")
            .font(.system(size: 24, weight: .medium))
          Text("Senaryo-Kural")
            .font(.system(size: 14, weight: .medium))
        }
        .tag(1)
      }
      
      // Channels Tab - Only for Admin
      if authManager.hasPermission(for: .viewChannels) {
        NavigationView {
          ChannelListView()
        }
        .tabItem {
          Image(systemName: "antenna.radiowaves.left.and.right")
            .font(.system(size: 20, weight: .medium))
          Text("Kanallar")
            .font(.system(size: 12, weight: .medium))
        }
        .tag(2)
      }
      
      // Users Tab - Only for Admin
      if authManager.hasPermission(for: .viewUsers) {
        NavigationView {
          UserListView()
        }
        .tabItem {
          Image(systemName: "person.3")
            .font(.system(size: 20, weight: .medium))
          Text("Kullanıcılar")
            .font(.system(size: 12, weight: .medium))
        }
        .tag(3)
      }
      
      // Profile Tab - Available for all roles
      NavigationView {
        ProfileView()
      }
      .tabItem {
        Image(systemName: "person.circle")
          .font(.system(size: 20, weight: .medium))
        Text("Profil")
          .font(.system(size: 12, weight: .medium))
      }
      .tag(4)
    }
    .onAppear {
      // Set initial tab based on available tabs
      let availableTabs = authManager.getAvailableTabs()
      if !availableTabs.isEmpty {
        selectedTab = 0
      }
    }
  }
}



// MARK: - Profile View
struct ProfileView: View {
  @EnvironmentObject var authManager: AuthManager
  @State private var showingLogoutAlert = false
  
  var body: some View {
    VStack(spacing: 0) {
      // User Info Section
      VStack(alignment: .leading, spacing: 12) {
        Text("Kullanıcı Bilgileri")
          .font(.headline)
          .foregroundColor(.primary)
          .padding(.horizontal)
          .padding(.top)
        
        if let user = authManager.currentUser {
          HStack {
            Image(systemName: "person.circle.fill")
              .font(.title)
              .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
              Text(user.username)
                .font(.headline)
              
              if let email = user.email {
                Text(email)
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }
            }
            
            Spacer()
            
            Text(user.role.displayName)
              .font(.caption)
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(roleColor.opacity(0.2))
              .foregroundColor(roleColor)
              .cornerRadius(6)
          }
          .padding(.horizontal)
          .padding(.bottom)
          .background(Color(.systemGray6))
        }
      }
      
      Divider()
      
      // Permissions Section
      VStack(alignment: .leading, spacing: 12) {
        Text("Yetkiler")
          .font(.headline)
          .foregroundColor(.primary)
          .padding(.horizontal)
          .padding(.top)
        
        VStack(spacing: 8) {
          PermissionRow(title: "Senaryoları Görüntüle", hasPermission: authManager.hasPermission(for: .viewScenarios))
          PermissionRow(title: "Senaryo Oluştur/Düzenle", hasPermission: authManager.hasPermission(for: .createScenarios))
          PermissionRow(title: "Senaryo-Kural Eşleştirme", hasPermission: authManager.hasPermission(for: .viewScenarios))
          PermissionRow(title: "Kural Oluştur/Düzenle", hasPermission: authManager.hasPermission(for: .createRules))
          PermissionRow(title: "Kanalları Yönet", hasPermission: authManager.hasPermission(for: .viewChannels))
          PermissionRow(title: "Kullanıcıları Yönet", hasPermission: authManager.hasPermission(for: .viewUsers))
        }
        .padding(.horizontal)
        .padding(.bottom)
      }
      
      Divider()
      
      // Actions Section
      VStack(alignment: .leading, spacing: 12) {
        Text("İşlemler")
          .font(.headline)
          .foregroundColor(.primary)
          .padding(.horizontal)
          .padding(.top)
        
        Button(action: {
          showingLogoutAlert = true
        }) {
          HStack {
            Image(systemName: "arrow.right.square")
              .foregroundColor(.red)
            Text("Çıkış Yap")
              .foregroundColor(.red)
            Spacer()
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.bottom)
      }
      
      Spacer()
    }
    .navigationTitle("Profil")
    .alert("Çıkış Yap", isPresented: $showingLogoutAlert) {
      Button("İptal", role: .cancel) { }
      Button("Çıkış Yap", role: .destructive) {
        authManager.logout()
      }
    } message: {
      Text("Uygulamadan çıkmak istediğinizden emin misiniz?")
    }
  }
  
  private var roleColor: Color {
    guard let role = authManager.currentUser?.role else { return .gray }
    switch role {
    case .admin:
      return .red
    case .user:
      return .blue
    case .viewer:
      return .orange
    }
  }
}

struct PermissionRow: View {
  let title: String
  let hasPermission: Bool
  
  var body: some View {
    HStack {
      Image(systemName: hasPermission ? "checkmark.circle.fill" : "xmark.circle.fill")
        .foregroundColor(hasPermission ? .green : .red)
      
      Text(title)
        .foregroundColor(hasPermission ? .primary : .secondary)
      
      Spacer()
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}