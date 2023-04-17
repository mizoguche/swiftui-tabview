import SwiftUI

struct SlideTabContent: Identifiable {
    var id: Int
    var title: String
    var view: AnyView
}

struct SlideTabView: View {
    @State var tabContents: [SlideTabContent]
    @State var selected: Int = 0
    @State private var indicatorPosition: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            VStack(spacing: 0) {
                SlideTabBarView(tabBars: tabContents.map{( $0.id, $0.title )},
                                color: .black,
                                selected: $selected,
                                indicatorPosition: $indicatorPosition)
                .frame(height: 48)
                
                TabView(selection: $selected) {
                    ForEach(tabContents) { tabViewType in
                        tabViewType.view
                            .tag(tabViewType.id)
                            .overlay {
                                GeometryReader{ proxy in
                                    Color.clear
                                        .onChange(of: proxy.frame(in: .global), perform: { value in
                                            // 表示中のタブをスワイプした時のみ処理する
                                            guard selected == tabViewType.id else { return }
                                            
                                            // 対象タブのスワイプ量をTabBarの比率に変換して、インジケーターのoffsetを計算する
                                            let offset = -(value.minX - (screenWidth * CGFloat(selected))) / tabCount
                                            
                                            if selected == tabContents.first?.id {
                                                // 最初のタブの場合、offsetが0以上の時のみ位置を更新する
                                                if offset >= 0 {
                                                    indicatorPosition = offset
                                                } else {
                                                    return
                                                }
                                            }
                                            
                                            if selected == tabContents.last?.id {
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
                .animation(.easeInOut, value: selected)
            }
        }
    }
    
    private var tabCount: CGFloat {
        CGFloat(tabContents.count)
    }
}

struct SlideTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlideTabView(tabContents: [SlideTabContent(id: 0, title: "Page1", view: AnyView(PageView(color: .red))),
                                   SlideTabContent(id: 1, title: "Page2", view: AnyView(PageView(color: .green))),
                                   SlideTabContent(id: 2, title: "Page3", view: AnyView(PageView(color: .blue)))])
    }
}
