import SwiftUI

struct BasicSampleView: View {
    var body: some View {
        TabView {
            BasicPage1()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Page1")
                }
            BasicPage2()
                .tabItem {
                    Image(systemName:"2.circle.fill")
                    Text("Page2")
                }
        }
    }
}

struct BasicSampleView_Previews: PreviewProvider {
    static var previews: some View {
        BasicSampleView()
    }
}

struct BasicPage1: View {
    var body: some View {
        Text("Page1")
    }
}
struct BasicPage2: View {
    var body: some View {
        Text("Page2")
    }
}
struct BasicPage3: View {
    var body: some View {
        Text("Page3")
    }
}

