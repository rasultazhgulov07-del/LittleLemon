import SwiftUI

struct DishDetailView: View {
    let dish: Dish

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: dish.imageSymbol)
                    .font(.system(size: 120))
                    .foregroundStyle(LemonTheme.green)
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(LemonTheme.cream, in: RoundedRectangle(cornerRadius: 16))
                Text(dish.title).font(.largeTitle.bold())
                Text(dish.category.uppercased()).font(.caption.bold()).foregroundStyle(LemonTheme.green)
                Text(dish.description).font(.body)
                Text(dish.priceLabel).font(.title2.bold())
                Spacer()
            }.padding(20)
        }
        .navigationTitle("Dish details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
