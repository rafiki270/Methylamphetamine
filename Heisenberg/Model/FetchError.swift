import Foundation


public enum FetchError: Error {
    case statusCode
    case missingData
    case noInternetConnection
    case other(Error)
    
    static func map(_ error: Error) -> FetchError {
        return (error as? FetchError) ?? .other(error)
    }
    
}
