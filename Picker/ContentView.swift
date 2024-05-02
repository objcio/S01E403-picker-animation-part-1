//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var title: String
}

struct Picker: View {
    @State private var selection: UUID?
    var items = ["Inbox", "Sent", "Archive"].map { Item(title: $0) }
    @Namespace private var namespace

    var body: some View {
        let selectedItem = selection ?? items[0].id
        HStack {
            ForEach(items) { item in
                Button(item.title) {
                    selection = item.id
                }
                .padding(.bottom, 4)
                .matchedGeometryEffect(id: item.id, in: namespace)
            }
        }
        .overlay {
            Color.accentColor
                .frame(height: 1)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .matchedGeometryEffect(id: selectedItem, in: namespace, isSource: false)
        }
        .buttonStyle(.plain)
        .animation(.default, value: selectedItem)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Picker()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
