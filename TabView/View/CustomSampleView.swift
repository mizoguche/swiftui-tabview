import SwiftUI

struct CustomSampleView: View {
    @State var selected = 0
    @State private var indicatorPosition: CGFloat = 0
        
    var body: some View {
        GeometryReader { geometry in
            let screenSize = geometry.size
            
            VStack(spacing: 0) {
                CustomTabBarView(screenWidth: screenSize.width, selected: $selected, indicatorPosition: $indicatorPosition)
                
                TabView(selection: $selected) {
                    CustomPage1().tag(0)
                        .overlay {
                            GeometryReader{ proxy in
                                Color.clear
                                    .onChange(of: proxy.frame(in: .global), perform: { value in
                                        if selected == 0 {
                                            let offset = -(value.minX - (screenSize.width * CGFloat(selected)))/3
                                            if offset > 0 {
                                                indicatorPosition = offset
                                            }
                                            print(offset)
                                        }
                                    })
                            }
                        }
                    CustomPage2().tag(1)
                        .overlay {
                            GeometryReader{ proxy in
                                Color.clear
                                    .onChange(of: proxy.frame(in: .global), perform: { value in
                                        if selected == 1 {
                                            let offset = -(value.minX - (screenSize.width * CGFloat(selected)))/3
                                            indicatorPosition = offset
                                            print(offset)
                                        }
                                    })
                            }
                        }
                    CustomPage3().tag(2)
                        .overlay {
                            GeometryReader{ proxy in
                                Color.clear
                                    .onChange(of: proxy.frame(in: .global), perform: { value in
                                        if selected == 2 {
                                            let offset = -(value.minX - (screenSize.width * CGFloat(selected)))/3
                                            if offset + screenSize.width/3 <= screenSize.width {
                                                indicatorPosition = offset
                                            }
                                            print(offset)
                                        }
                                    })
                            }
                        }
                }
                // ページスタイル（インジケータ非表示）
                .tabViewStyle(.page(indexDisplayMode: .never))
                // 切り替え時のアニメーション
                .animation(.easeInOut, value: selected)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct CustomSampleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSampleView()
    }
}

struct CustomPage1: View {
    var body: some View {
        Color.red
            .ignoresSafeArea()
    }
}

struct CustomPage2: View {
    var body: some View {
        Color.green
            .ignoresSafeArea()
    }
}

struct CustomPage3: View {
    var body: some View {
        Color.blue
            .ignoresSafeArea()
    }
}
