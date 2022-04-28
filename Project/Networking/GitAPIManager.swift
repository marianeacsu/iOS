import Foundation
import Alamofire

class GitAPIManager {
    
    func searchRepositories(query: String, completion: @escaping ([Repository]) -> Void) {
        let url = "https://api.github.com/search/repositories"
        var queryParameters: [String: Any] = ["sort": "stars", "order": "desc", "page": 1]
        queryParameters["q"] = query
        AF.request(url, parameters: queryParameters)
            .responseDecodable(of: Repositories.self) { response in
                guard let items = response.value else {
                    return completion([])
                }
                completion(items.items)
            }
    }
    
    func getReadmeFrom(fullname: String, completion: @escaping (String) -> Void) {
        let url = "https://api.github.com/repos/\(fullname)/readme"
        AF.request(url)
            .responseDecodable(of: Readme.self) { response in
                guard let content = response.value else {
                    return completion("")
                }
                
                guard let decodedContent = content.content.base64ToString() else {
                    return completion("")
                }
                
                completion(decodedContent)
            }
    }
}
