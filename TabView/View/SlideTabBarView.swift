import SwiftUI

struct SlideTabBarView: View {
    let tabBars: [(id: Int, title: String)]
    let color: Color
    
    @EnvironmentObject var viewModel: SlideTabBarViewModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(tabBars, id: \.id) { tabBar in
                    Button {
                        viewModel.selection = tabBar.id
                        viewModel.indicatorPosition = tabBarWidth(width: geometry.size.width) * CGFloat(tabBar.id)
                    } label: {
                        Text(tabBar.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(color)
                            .padding(8)
                    }
                }
            }
            .overlay(alignment: .bottomLeading) {
                Rectangle()
                    .foregroundColor(color)
                    .frame(width: tabBarWidth(width: geometry.size.width), height: 4)
                    .offset(x: viewModel.indicatorPosition, y: 0)
            }
        }
    }
    
    private var tabBarCount: CGFloat {
        CGFloat(tabBars.count)
    }
    
    private func tabBarWidth(width: CGFloat) -> CGFloat {
        width / CGFloat(tabBars.count)
    }

    private func tabBarIndicatorWidth(width: CGFloat) -> CGFloat {
        width / CGFloat(tabBars.count)
    }
}

//struct SlideTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideTabBarView(tabBars: [(id: 0, title: "Page1"),
//                                  (id: 1, title: "Page2"),
//                                  (id: 2, title: "Page3")],
//                        color: .black,
//                        selection: .constant(0),
//                        indicatorPosition: .constant(0))
//    }
//}
