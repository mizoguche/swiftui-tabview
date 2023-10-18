import SwiftUI



struct CustomSampleView: View {
    @State private var tabViewHeight: CGFloat = 0
    @ObservedObject private var viewModel = SlideTabBarViewModel()
        
    var body: some View {
        VStack(spacing: 0) {
            sectionHeader
            
            SlideTabView(tabContents: [
                SlideTabContent(id: 0, title: "Page1", content: PageView(color: .red, count: 5, height: $tabViewHeight)),
                SlideTabContent(id: 1, title: "Page2", content: PageView(color: .green, count: 3, height: $tabViewHeight)),
                SlideTabContent(id: 2, title: "Page3", content: PageView(color: .blue, count: 10, height: $tabViewHeight))
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
    let color: Color
    let count: Int
    @Binding var height: CGFloat
    
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
                        height = proxy.size.height
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
