import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Basic Sample", destination: { BasicSampleView() })
                NavigationLink("Custom Sample", destination: { CustomSampleView() })
                NavigationLink("StickyHeader Sample", destination: { StickyHeaderTabView() })
            }
            .navigationTitle("TabView")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
