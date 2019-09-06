import UIKit

extension UIAlertController {
    static func makeRetry(errorDescription: String, retryCompletion: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        
        enum Constants {
            static let OhNo = "Oh No".localized()
            static let retry = "Retry".localized()
            static let cancel = "Cancel".localized()
        }
        
        let alertController = UIAlertController(title: Constants.OhNo,
                                                message: errorDescription,
                                                preferredStyle: .alert)
        let retry = UIAlertAction(title: Constants.retry, style: .default, handler: retryCompletion)
        let cancel = UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil)
        
        alertController.addAction(retry)
        alertController.addAction(cancel)
        
        return alertController
    }
}
