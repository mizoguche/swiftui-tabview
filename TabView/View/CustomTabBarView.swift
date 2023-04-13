import SwiftUI

struct CustomTabBarView: View {
    let screenWidth: CGFloat
    @Binding var selected: Int
    @Binding var indicatorPosition: CGFloat
    
    var body: some View {
        HStack {
            CustomTabBarButtonView(selected: $selected, title: "Page1", tag: 0)
            CustomTabBarButtonView(selected: $selected, title: "Page2", tag: 1)
            CustomTabBarButtonView(selected: $selected, title: "Page3", tag: 2)
        }
        .overlay(alignment: .bottomLeading) {
            Rectangle()
                .foregroundColor(.black)
                .frame(width: screenWidth/3, height: 4)
                .offset(x: indicatorPosition, y: 0)
        }
    }
}
