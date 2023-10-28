import SwiftUI



struct CustomSampleView: View {
    @State private var tabViewHeight: CGFloat = 0
    @State private var tabViewHeights: [Int: CGFloat] = [:]
    @StateObject private var viewModel = SlideTabBarViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            sectionHeader
            
            SlideTabView(tabContents: [
                SlideTabContent(id: 0, title: "Page1", content: PageView(color: .red)),
                SlideTabContent(id: 1, title: "Page2", content: PageView(color: .green)),
                SlideTabContent(id: 2, title: "Page3", content: PageView(color: .blue))
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
    
    var body: some View {
        color.ignoresSafeArea()
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
