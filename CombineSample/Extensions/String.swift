import Foundation

extension String {
    
    var cleaned: String {
        self.replacingOccurrences(of: "-", with: " ").capitalized
    }
}
