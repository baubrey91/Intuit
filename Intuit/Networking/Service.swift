import Foundation
import UIKit

enum ServiceError: Error {
    case invalidData
    case unknownResponse
    case requestError
}

protocol Service {
    func get(request: Requests, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: Service {
    public func get(request: Requests, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request.url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                //300 Redirection messages
                //400 Client error responses
                //500 Server error responses
                if  statusCode >= 300 {
                    completion(.failure(ServiceError.requestError))
                    return
                }
            }
            guard let data = data  else {
                completion(.failure(ServiceError.invalidData))
                return
            }
            completion(.success(data))
            }.resume()
    }
}
