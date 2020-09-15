import SwiftUI
import Heisenberg


struct DetailScreenView: View {
    
    @ObservedObject var viewModel: DetailScreenViewModel
    
    var body: some View {
        VStack() {
            Image(uiImage: self.viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 240, height: 240)
                .clipShape(Circle())
                .overlay(
                    RoundedRectangle(cornerRadius: 120)
                        .stroke(viewModel.person.status.color, lineWidth: 4)
            )
                .onAppear {
                    self.viewModel.fetchImage()
            }
            Text(viewModel.person.name)
                .font(.headline)
            Text(viewModel.person.nickname ?? "n/a")
            .font(.subheadline)
            .foregroundColor(.gray)
            
            Text(viewModel.person.status.rawValue)
                .font(.caption)
            .foregroundColor(.gray)
            
            Text(viewModel.person.occupation?.joined(separator: ", ") ?? "occupation not available")
                .font(.caption)
            .foregroundColor(.gray)
            
            Text("Season appearence: \(viewModel.person.appearance?.map({ String($0) }).joined(separator: ", ") ?? "n/a")")
                .font(.caption)
            .foregroundColor(.gray)
            
            Spacer()
        }
    }
    
}

struct DetailScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        let person = Person(id: 0, name: "Test Test", birthday: "?", occupation: nil, img: nil, nickname: "Test", appearance: [1,2], portrayed: "Test Test", category: "Test", betterCallSaulAppearance: nil)
        let vm = DetailScreenViewModel(person: person)
        return DetailScreenView(viewModel: vm)
    }
    
}

