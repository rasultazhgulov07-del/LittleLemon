import Foundation
import Combine

struct MenuResponse: Decodable {
    let menuList: [Dish]
}

struct Dish: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let imageSymbol: String

    var priceLabel: String { String(format: "$%.2f", price) }
}

@MainActor
final class MenuStore: ObservableObject {
    @Published private(set) var dishes: [Dish] = []
    @Published private(set) var errorMessage: String?

    init() { loadBundledMenu() }

    private func loadBundledMenu() {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else {
            errorMessage = "Bundled menu file is missing."
            return
        }
        do {
            let data = try Data(contentsOf: url)
            dishes = try JSONDecoder().decode(MenuResponse.self, from: data).menuList
        } catch {
            errorMessage = "Could not load menu: \(error.localizedDescription)"
        }
    }
}
