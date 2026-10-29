import SwiftUI

struct HomeView: View {
    @StateObject private var store = MenuStore()
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    private let categories = ["All", "Starters", "Mains", "Desserts", "Drinks"]

    private var filteredDishes: [Dish] {
        store.dishes.filter { dish in
            (selectedCategory == "All" || dish.category == selectedCategory) &&
            (searchText.isEmpty || dish.title.localizedCaseInsensitiveContains(searchText) ||
             dish.description.localizedCaseInsensitiveContains(searchText))
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                header
                hero
                VStack(alignment: .leading, spacing: 12) {
                    Text("ORDER FOR DELIVERY!").font(.headline).tracking(1)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 9) {
                            ForEach(categories, id: \.self) { category in
                                Button(category) { selectedCategory = category }
                                    .font(.subheadline.bold())
                                    .padding(.horizontal, 16).padding(.vertical, 10)
                                    .background(selectedCategory == category ? LemonTheme.green : LemonTheme.cream,
                                                in: Capsule())
                                    .foregroundStyle(selectedCategory == category ? Color.white : LemonTheme.green)
                                    .accessibilityAddTraits(selectedCategory == category ? .isSelected : [])
                            }
                        }
                    }
                }
                Rectangle().fill(Color.gray.opacity(0.2)).frame(height: 1)
                Text("Food menu").font(.title2.bold())
                if let error = store.errorMessage { Text(error).foregroundStyle(.red) }
                if filteredDishes.isEmpty { Text("No matching dishes found.").foregroundStyle(.secondary) }
                LazyVStack(spacing: 0) {
                    ForEach(filteredDishes) { dish in
                        NavigationLink {
                            DishDetailView(dish: dish)
                        } label: {
                            DishRow(dish: dish)
                        }
                        .buttonStyle(.plain)
                        Divider().padding(.vertical, 12)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(.white)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack {
            Text("LITTLE LEMON")
                .font(.system(size: 22, weight: .black, design: .rounded))
                .foregroundStyle(LemonTheme.green)
            Image(systemName: "leaf.fill").foregroundStyle(LemonTheme.yellow)
            Spacer()
            NavigationLink { ProfileView() } label: {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(LemonTheme.green)
                    .accessibilityLabel("Open profile")
            }
        }.padding(.top, 12)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Little Lemon").font(.largeTitle.bold()).foregroundStyle(LemonTheme.yellow)
                    Text("Chicago").font(.title2).foregroundStyle(.white)
                    Text("Family-owned Mediterranean food, fresh ingredients and memorable flavors.")
                        .font(.subheadline).foregroundStyle(.white)
                }
                Spacer(minLength: 0)
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 82)).foregroundStyle(LemonTheme.yellow)
            }
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                TextField("Search the menu", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityLabel("Search menu")
            }
            .padding(12)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
        }
        .padding(18)
        .background(LemonTheme.green, in: RoundedRectangle(cornerRadius: 14))
    }
}

private struct DishRow: View {
    let dish: Dish
    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 7) {
                Text(dish.title).font(.headline)
                Text(dish.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                Text(dish.priceLabel).font(.subheadline.bold()).foregroundStyle(LemonTheme.green)
            }
            Spacer(minLength: 4)
            Image(systemName: dish.imageSymbol)
                .font(.system(size: 40))
                .foregroundStyle(LemonTheme.green)
                .frame(width: 88, height: 88)
                .background(LemonTheme.cream, in: RoundedRectangle(cornerRadius: 10))
        }
        .contentShape(Rectangle())
    }
}
