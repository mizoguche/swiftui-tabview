import SwiftUI

struct SlideTabContent<Content: View>: Identifiable {
    var id: Int
    var title: String
    var content: Content
}

struct SlideTabView<Content: View>: View {
    @State var tabContents: [SlideTabContent<Content>]
    @State var selection: Int = 0
    @State private var indicatorPosition: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let safeAreaInsetsLeading = geometry.safeAreaInsets.leading
            
            VStack(spacing: 0) {
                SlideTabBarView(tabBars: tabContents.map{( $0.id, $0.title )},
                                color: .black,
                                selection: $selection,
                                indicatorPosition: $indicatorPosition)
                .frame(height: 48)
                
                TabView(selection: $selection) {
                    ForEach(tabContents) { tabViewType in
                        tabViewType.content
                            .tag(tabViewType.id)
                            .overlay {
                                GeometryReader{ proxy in
                                    Color.clear
                                        .onChange(of: proxy.frame(in: .global), perform: { value in
                                            // 表示中のタブをスワイプした時のみ処理する
                                            guard selection == tabViewType.id else { return }
                                            
                                            // 対象タブのスワイプ量をTabBarの比率に変換して、インジケーターのoffsetを計算する
                                            let offset = -(value.minX - safeAreaInsetsLeading - (screenWidth * CGFloat(selection))) / tabCount
                                            
                                            if selection == tabContents.first?.id {
                                                // 最初のタブの場合、offsetが0以上の時のみ位置を更新する
                                                if offset >= 0 {
                                                    indicatorPosition = offset
                                                } else {
                                                    return
                                                }
                                            }
                                            
                                            if selection == tabContents.last?.id {
                                                // 最後のタブの場合、offsetがscreenWidth以下の時のみ位置を更新する
                                                if offset + screenWidth/tabCount <= screenWidth {
                                                    indicatorPosition = offset
                                                } else {
                                                    return
                                                }
                                            }
                                            
                                            indicatorPosition = offset
                                        })
                                }
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: selection)
            }
        }
    }
    
    private var tabCount: CGFloat {
        CGFloat(tabContents.count)
    }
}

struct SlideTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlideTabView(tabContents: [SlideTabContent(id: 0, title: "Page1", content: PageView(color: .red)),
                                   SlideTabContent(id: 1, title: "Page2", content: PageView(color: .green)),
                                   SlideTabContent(id: 2, title: "Page3", content: PageView(color: .blue))])
    }
}
