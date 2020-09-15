import SwiftUI
import Heisenberg


final class DetailScreenViewModel: ObservableObject {
    
    @Published var person: Person
    
    var worker = FetchHeisenberg()
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var image: UIImage
    
    init(person: Person, image: UIImage = UIImage.default) {
        self.person = person
        self.image = image
    }
    
    func fetchImage() {
        let publisher = try? worker.get(image: person.img!)
        publisher?.sink(receiveValue: { data in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self.image = image
        }).store(in: &cancellables)
    }
    
}
