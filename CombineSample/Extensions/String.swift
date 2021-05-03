import Foundation

extension String {
    
    var cleaned: String { replacingOccurrences(of: "-", with: " ").capitalized }
}
