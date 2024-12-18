import SwiftUI

struct Fellowship: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let url: String
    let due_date: String
    let value: Int
}

class FellowshipViewModel: ObservableObject {
    @Published var fellowships: [Fellowship] = []
    
    init() {
        loadFellowships()
    }
    
    func loadFellowships() {
        guard let url = Bundle.main.url(forResource: "fellowships", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error loading JSON data")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            fellowships = try decoder.decode([Fellowship].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = FellowshipViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.fellowships) { fellowship in
                VStack(alignment: .leading, spacing: 8) {
                    Text(fellowship.name)
                        .font(.headline)
                    Text(fellowship.description)
                        .font(.subheadline)
                        .lineLimit(3)
                    Text("Due Date: \(fellowship.due_date)")
                        .font(.caption)
                    Link("Visit Website", destination: URL(string: fellowship.url)!)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Graduate Fellowships")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

