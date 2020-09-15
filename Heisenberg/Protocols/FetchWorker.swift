import Combine


public protocol FetchWorker {
    
    associatedtype DataType
    
    func get() throws -> AnyPublisher<DataType, Never>
    
}
