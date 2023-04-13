import SwiftUI

struct CustomTabBarButtonView: View {
    @Binding var selected: Int
    var title: String
    var tag: Int
    
    var body: some View {
        Button {
            selected = tag
        } label: {
            VStack(spacing: 0) {
                Text(title)
                    .foregroundColor(.black)
                    .padding(8)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 4)
            }
            
        }
    }
}

struct CustomTabBarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarButtonView(selected: .constant(0), title: "Page", tag: 0)
    }
}
