import Combine
import Alamofire


public final class FetchHeisenberg: FetchWorker {
    
    let url = "https://breakingbadapi.com/api/characters"
    
    public func get() throws -> AnyPublisher<People, Never> {
        guard NetworkReachabilityManager.default?.isReachable == true else {
            throw FetchError.noInternetConnection
        }
        let req = AF.request(url)
        return req.publishData()
            .tryMap { response -> Data in
                guard response.response?.statusCode == 200 else {
                    throw FetchError.statusCode
                }
                guard let data = response.data else {
                    throw FetchError.missingData
                }
                return data
        }
            //        .decode(type: People.self, decoder: JSONDecoder())
            
            .map { data in
                let decoded = try! JSONDecoder().decode(People.self, from: data)
                return decoded
        }
        .replaceError(with: [])
        .eraseToAnyPublisher()
    }
    
    public func get(image url: String) throws -> AnyPublisher<Data?, Never> {
        guard NetworkReachabilityManager.default?.isReachable == true else {
            throw FetchError.noInternetConnection
        }
        let req = AF.request(url)
        return req.publishData()
            .tryMap { response -> Data in
                guard response.response?.statusCode == 200 else {
                    throw FetchError.statusCode
                }
                guard let data = response.data else {
                    throw FetchError.missingData
                }
                return data
        }
        .replaceError(with: nil)
        .eraseToAnyPublisher()
    }
    
    public init() { }
    
}
