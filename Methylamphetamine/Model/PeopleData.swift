import SwiftUI
import Combine


final class PeopleData: ObservableObject {
    
    let didChange = PassthroughSubject<PeopleData, Never>()
    
}
