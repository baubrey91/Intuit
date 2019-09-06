import Foundation
import UIKit

enum urlError: Error {
    case badRequst
}

protocol IntuitAPI {
    func getIntuitRepo(completion: @escaping (Result<[Repo], Error>) -> Void)
    func getIssues(for repo: String, completion: @escaping (Result<[Issue], Error>) -> Void)
    func getAvatarImage(with imagePath: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
}

class IntuitClient: IntuitAPI {
    let service: NetworkService
    
    public init(netService: NetworkService? = nil) {
        self.service = netService ?? NetworkService()
    }
    
    func getIntuitRepo(completion: @escaping (Result<[Repo], Error>) -> Void) {
        #if OFFLINE
        return callJSONFile(completion: completion)
        #endif
        guard let request = GitHubRequest(endpoint: .repos) else {
            DispatchQueue.global().async {
                //Bad URL
                //RENAME
                completion(.failure(urlError.badRequst))
            }
            return
        }
        
        service.get(request: request) { (result: Result<Data, Error>) in
            do {
                switch result {
                case .success(let data):
                    let repos = try JSONDecoder().decode([Repo].self, from: data)
                    completion(.success(repos))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(ServiceError.invalidData))
            }
        }
    }
    
    func getIssues(for repo: String, completion: @escaping (Result<[Issue], Error>) -> Void) {
//        #if OFFLINE
//        //differentJSONFILE
//        return callJSONFile(completion: completion)
//        #endif

        guard let request = GitHubRequest(endpoint: .issues(repo: repo)) else {
            DispatchQueue.global().async {
                completion(.failure(urlError.badRequst))
            }
            return
        }
        service.get(request: request) { (result: Result<Data, Error>) in
            do {
                switch result {
                case .success(let data):
                    let issues = try JSONDecoder().decode([Issue].self, from: data)
                    completion(.success(issues))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(ServiceError.invalidData))
            }
        }
    }

    
    func getAvatarImage(with imagePath: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let request = AvatarImageRequest(imagePath: imagePath) else {
            DispatchQueue.global().async {
                completion(Result.failure(ServiceError.requestError))
            }
            return
        }
        service.get(request: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                // TODO: - Remove force unwrap
                let image = UIImage(data: data)!
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//Offline mode
extension IntuitClient {
    //Used only for working on project offline.
    private func callJSONFile(completion: @escaping (Result<[Repo], Error>) -> Void) {
        //I am force unwrapping only because none of this should go to production. This is for just working offline
        let fileUrl: NSURL = Bundle.main.url(forResource: "mockJSONFile", withExtension: "json")! as NSURL
        let data: Data = try! Data(contentsOf: fileUrl as URL)
        let repos = try! JSONDecoder().decode([Repo].self, from: data)
        completion(.success(repos))
    }
}
