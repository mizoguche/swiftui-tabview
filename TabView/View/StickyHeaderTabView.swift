import SwiftUI

final class SlideTabBarViewModel: ObservableObject {
    @Published var selection: Int = 0
    @Published var indicatorPosition: CGFloat = 0
}

struct StickyHeaderTabView: View {
    @State private var tabViewHeight: CGFloat = UIScreen.main.bounds.height
    @State private var tabViewHeights: [Int: CGFloat] = [:]
    @StateObject private var viewModel = SlideTabBarViewModel()
    
    let listViewModels = [
        0: ListViewModel(id: 0, color: .red, pageSize: 5),
        1: ListViewModel(id: 1, color: .green, pageSize: 3),
        2: ListViewModel(id: 2, color: .blue, pageSize: 10)
    ]
        
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    Color.gray
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .padding(.bottom, 10)
                    
                    Section(header: sectionHeader, footer: sectionFooter) {
                        SlideTabView(tabContents: [
                            SlideTabContent(id: 0, title: "Page1", content: ListView(viewModel: listViewModels[0]!, onHeightChanged: { id, height in
                                tabViewHeights[id] = height
                            })),
                            SlideTabContent(id: 1, title: "Page2", content: ListView(viewModel: listViewModels[1]!, onHeightChanged: { id, height in
                                tabViewHeights[id] = height
                            })),
                            SlideTabContent(id: 2, title: "Page3", content: ListView(viewModel: listViewModels[2]!, onHeightChanged: { id, height in
                                tabViewHeights[id] = height
                            }))
                        ])
                        .frame(height: tabViewHeights[viewModel.selection] ?? UIScreen.main.bounds.height)
                        .onChange(of: viewModel.selection) { newValue in
                            print("new selection: \(newValue), size.height: \(proxy.size.height), tabViewHeights[viewModel.selection]: \(tabViewHeights[viewModel.selection])")
                        }
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
    
    var sectionFooter: some View {
        // リストの下にViewがあると、タブを切り替えた時に余白ができてしまうことがありそう
        FooterLoadingView(isVisible: true) {
            Task {
                print("onPageEnd")
                await listViewModels[viewModel.selection]?.onPageEnd()
            }
        }
        .frame(height: 60)
    }
}
