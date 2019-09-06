import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
