import SwiftUI


struct HomeScreenView: View {
    
    @ObservedObject var viewModel = HomeScreenViewModel()
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .accessibility(identifier: "Search")
                List(viewModel.people.filter {
                    self.searchText.isEmpty ? true : $0.name.lowercased().contains(self.searchText.lowercased())
                }) { person in
                    NavigationLink(
                        destination: DetailScreenView(
                            viewModel: DetailScreenViewModel(
                                person: person,
                                image: self.viewModel.images[person] ?? UIImage.default
                            )
                        )
                    ) {
                        HStack {
                            Image(uiImage: self.viewModel.images[person] ?? UIImage.default)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(person.status.color, lineWidth: 4)
                                )
                                .onAppear {
                                    self.viewModel.fetch(imageFor: person)
                            }
                            VStack(alignment: .leading) {
                                Text(person.name)
                                Text(person.nickname ?? "n/a")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onAppear(perform: viewModel.fetch)
                .navigationBarTitle("Methylamphetamine")
                .navigationBarItems(trailing: NavigationLink(
                    destination: FilterSelectorView(
                        seasons: viewModel.seasons,
                        selectedSeasonIndex: viewModel.selectedSeasonIndex
                    ) { season in
                        self.viewModel.filter(forSeason: season)
                }) {
                    Text("Filters")
                })
            }
        }
    }
    
}

struct HomeScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        let v = HomeScreenView()
        return v
    }
    
}
