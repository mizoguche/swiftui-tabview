import SwiftUI

struct CustomSampleView: View {
    @State var selected = 0
        
    var body: some View {
        VStack(spacing: 0) {
            CustomTabBarView(selected: $selected)
            
            TabView(selection: $selected) {
                CustomPage1().tag(0)
                CustomPage2().tag(1)
                CustomPage3().tag(2)
            }
            .disabled(true)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: selected)
        }
        .ignoresSafeArea(edges: .bottom)
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
