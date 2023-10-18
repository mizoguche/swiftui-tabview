import SwiftUI

final class SlideTabBarViewModel: ObservableObject {
    @Published var selection: Int = 0
    @Published var indicatorPosition: CGFloat = 0
}

struct StickyHeaderTabView: View {
    @State private var tabViewHeight: CGFloat = UIScreen.main.bounds.height
    @State private var tabViewHeights: [Int: CGFloat] = [:]
    @StateObject private var viewModel = SlideTabBarViewModel()
        
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    ForEach(0..<5) { _ in
                        Color.gray
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .padding(.bottom, 10)
                    }
                    
                    Section(header: sectionHeader) {
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
                        .frame(height: tabViewHeight)
                        .onChange(of: viewModel.selection) { selection in
                            if let height = tabViewHeights[selection] {
                                tabViewHeight = height
                            }
                        }
                        .animation(.easeInOut, value: viewModel.selection)
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .environmentObject(viewModel)
    }
    
    func tabViewHeight(proxy: GeometryProxy) -> CGFloat {
        let height = proxy.size.height - 48
        return height > 0 ? height : 0
    }
    
    var sectionHeader: some View {
        SlideTabBarView(tabBars: [(id: 0, title: "Page1"),
                                  (id: 1, title: "Page2"),
                                  (id: 2, title: "Page3")],
                        color: .black)
        .background(Color.white)
        .frame(height: 48)
    }
}
