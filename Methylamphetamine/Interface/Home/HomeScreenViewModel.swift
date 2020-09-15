import SwiftUI
import Heisenberg


final class HomeScreenViewModel: ObservableObject {
    
    var allPeople: People = [] {
        didSet {
            people = allPeople
        }
    }
    
    var worker = FetchHeisenberg()
    
    @Published var people: People = []
    @Published var images: [Person: UIImage] = [:]
    @Published var selectedSeasonIndex: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetch() {
        guard allPeople.count == 0 else {
            return
        }
        let publisher = try? worker.get()
        publisher?.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError("Display error message for \(error)")
            }
        }, receiveValue: { people in
            self.allPeople = people
        }).store(in: &cancellables)
    }
    
    func fetch(imageFor person: Person) {
        let publisher = try? worker.get(image: person.img!)
        publisher?.sink(receiveValue: { data in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self.images[person] = image
        }).store(in: &cancellables)
    }
    
    func filter(forSeason season: String) {
        selectedSeasonIndex = seasons.lastIndex(of: season) ?? 0
        
        guard season != "All" else {
            people = allPeople
            return
        }
        people = allPeople.filter({ $0.appearance?.contains(Int(season) ?? 0) ?? false })
    }
    
    var seasons: [String] {
        var set: Set<Int> = []
        for p in people {
            guard let appearance = p.appearance else {
                continue
            }
            set.insert(appearance)
        }
        var ret = ["All"]
        ret.append(contentsOf: set.map { String($0) }.sorted())
        return ret
    }
    
}
