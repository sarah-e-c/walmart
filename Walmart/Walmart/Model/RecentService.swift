import Foundation

class RecentService {
    static var shared = RecentService()
    private let recentsKey = "recents"
    
    func loadRecents() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: recentsKey) else {
            print("No data saved.")
            return []
        }
        
        guard let favorites = try? JSONDecoder().decode([Product].self, from: data) else {
            print("Data failed to load.")
            return []
        }
        return favorites
    }
    
    func saveRecents(recents: [Product]) {
        guard let data = try? JSONEncoder().encode(recents) else {
            print("Cannot encode data.")
            return
        }
        
        UserDefaults.standard.setValue(data, forKey: recentsKey)
        print("successfully set favorites!")
    }
    
}
