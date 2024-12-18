import SwiftUI

struct Scholarship: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let url: String
    let due_date: String
    let value: Int
}

class ScholarshipViewModel: ObservableObject {
    @Published var scholarships: [Scholarship] = []
    
    init() {
        loadScholarships()
    }
    
    func loadScholarships() {
        guard let url = Bundle.main.url(forResource: "fellowships", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error loading JSON data")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            scholarships = try decoder.decode([Scholarship].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ScholarshipViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.scholarships) { scholarship in
                VStack(alignment: .leading, spacing: 8) {
                    Text(scholarship.name)
                        .font(.headline)
                    Text(scholarship.description)
                        .font(.subheadline)
                        .lineLimit(3)
                    Text("Due Date: \(scholarship.due_date)")
                        .font(.caption)
                    Link("Visit Website", destination: URL(string: scholarship.url)!)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Scholarships")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

