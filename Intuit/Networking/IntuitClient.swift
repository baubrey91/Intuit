import Foundation
import UIKit

enum urlError: Error {
    case badURL
}

public protocol IntuitAPI {
    func getIntuitRepo(completion: @escaping (Result<[Repo], Error>) -> Void)
}

class IntuitClient: IntuitAPI {
    let service: NetworkService
    
    public init(netService: NetworkService? = nil) {
        self.service = netService ?? NetworkService()
    }
    
    func getIntuitRepo(completion: @escaping (Result<[Repo], Error>) -> Void) {
        guard let request = movieRequest() else {
            DispatchQueue.global().async {
                //Bad URL
                //RENAME
                completion(.failure(urlError.badURL))
            }
            return
        }
        service.get(request: request) { (result: Result<Data, Error>) in
            do {
                switch result {
                case .success(let data):
                    print(data)
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [NSDictionary]
                    let repos = jsonData.map { Repo(json: $0) }
                    completion(.success(repos))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(ServiceError.invalidData))
            }
        }
    }
    
//    func getIntuitRepo(completion: @escaping (Result<String>) -> Void) {
//        guard let request = movieRequest(movieId: movieId) else {
//            DispatchQueue.global().async {
//                completion(Result.error(ServiceError.requestError))
//            }
//            return
//        }
//        service.get(request: request) { (result: Result<Data>) in
//            do {
//                switch result {
//                case .result(let data):
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//                    let movie = Movie(json: jsonData)
//                    completion(Result.result(movie))
//                case .error(let error):
//                    completion(Result.error(error))
//                }
//            } catch {
//                completion(Result.error(ServiceError.invalidData))
//            }
//        }
//    }
    
//    func getMovieImage(imagePath: String, completion: @escaping (Result<UIImage?>) -> Void) {
//        guard let request = movieImageRequest(imagePath: imagePath) else {
//            DispatchQueue.global().async {
//                completion(Result.error(ServiceError.requestError))
//            }
//            return
//        }
//        service.get(request: request) { (result: Result<Data>) in
//            switch result {
//            case .result(let data):
//                let image = UIImage(data: data)!
//                completion(Result.result(image))
//            case .error(let error):
//                completion(Result.error(error))
//            }
//        }
//    }
}
