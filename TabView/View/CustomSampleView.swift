import SwiftUI



struct CustomSampleView: View {
    @State private var tabViewHeight: CGFloat = 0
    @State private var tabViewHeights: [Int: CGFloat] = [:]
    @StateObject private var viewModel = SlideTabBarViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            sectionHeader
            
            SlideTabView(tabContents: [
                SlideTabContent(id: 0, title: "Page1", content: PageView(id: 0, color: .red, count: 5, onHeightChanged: { id, height in
                    tabViewHeights[id] = height
                })),
                SlideTabContent(id: 1, title: "Page2", content: PageView(id: 1, color: .green, count: 3, onHeightChanged: { id, height in
                    tabViewHeights[id] = height
                })),
                SlideTabContent(id: 2, title: "Page3", content: PageView(id: 2, color: .blue, count: 10, onHeightChanged: { id, height in
                    tabViewHeights[id] = height
                }))
            ])
            .ignoresSafeArea(edges: .bottom)
        }
        .environmentObject(viewModel)
    }
    
    private var sectionHeader: some View {
        SlideTabBarView(tabBars: [(id: 0, title: "Page1"),
                                  (id: 1, title: "Page2"),
                                  (id: 2, title: "Page3")],
                        color: .black)
        .background(Color.white)
        .frame(height: 48)
    }
}

struct PageView: View {
    let id: Int
    let color: Color
    let count: Int
    let onHeightChanged: (Int, CGFloat) -> Void
    
    var body: some View {
        LazyVStack() {
            ForEach(0..<count, id: \.self) { _ in
                color
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
            }
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        onHeightChanged(id, proxy.size.height)
                    }
            }
        )
    }
}

struct CustomSampleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSampleView()
    }
}

struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
