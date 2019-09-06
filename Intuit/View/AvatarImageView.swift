import UIKit

let imageCache = NSCache<NSString, UIImage>()

class AvatarImage: UIImageView {
    private var imagePath: String?
    private var intuitClient: IntuitClient = IntuitClient()
    
    public func imageFromServerURL(with imagePath: String) {
        self.imagePath = imagePath
        
        if let cachedImage = imageCache.object(forKey: NSString(string: imagePath)) {
            self.image = cachedImage
            return
        }
        
        intuitClient.getAvatarImage(with: imagePath) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let image):
                imageCache.setObject(image!, forKey: NSString(string: imagePath))
                if weakSelf.imagePath == imagePath {
                    DispatchQueue.main.async {
                        weakSelf.image = image
                    }
                }
            case .failure(let error):
                //Log Error somewhere
                print(error)
            }
        }
    }
}
