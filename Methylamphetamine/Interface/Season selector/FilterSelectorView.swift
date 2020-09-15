import SwiftUI


// - MARK: Implementation

struct FilterSelectorView: View {
    
    var seasons: [String]
    
    @State var selectedSeasonIndex: Int {
        didSet {
            didSelectSeason(seasons[selectedSeasonIndex])
        }
    }
    
    var didSelectSeason: ((String) -> ())
    
    var body: some View {
        return Form {
            Section {
                Picker(
                    selection: Binding(
                        get: { self.selectedSeasonIndex },
                        set: { self.selectedSeasonIndex = $0}
                    ),
                    label: Text("Select season")
                ) {
                    ForEach(0 ..< seasons.count) {
                        Text(self.seasons[$0])
                    }
                }
            }
        }
        .navigationBarTitle("Filters")
    }
    
}

struct FilterSelectorView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilterSelectorView(seasons: ["All", "1", "2", "3"], selectedSeasonIndex: 0) { _ in }
    }
    
}
