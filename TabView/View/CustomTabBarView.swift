import SwiftUI

struct CustomTabBarView: View {
    @Binding var selected: Int
    
    var body: some View {
        HStack {
            CustomTabBarButtonView(selected: $selected, title: "Page1", tag: 0)
            CustomTabBarButtonView(selected: $selected, title: "Page2", tag: 1)
            CustomTabBarButtonView(selected: $selected, title: "Page3", tag: 2)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(selected: .constant(0))
    }
}
