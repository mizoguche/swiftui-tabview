import SwiftUI

struct SlideTabBarView: View {
    let tabBars: [(id: Int, title: String)]
    let color: Color
//    @Binding var selection: Int
//    @Binding var indicatorPosition: CGFloat
    @EnvironmentObject var viewModel: SlideTabBarViewModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(tabBars, id: \.id) { tabBar in
                    Button {
                        viewModel.selection = tabBar.id
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
                    .frame(width: geometry.size.width / tabBarCount, height: 4)
                    .offset(x: viewModel.indicatorPosition, y: 0)
            }
        }
    }
    
    private var tabBarCount: CGFloat {
        CGFloat(tabBars.count)
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
