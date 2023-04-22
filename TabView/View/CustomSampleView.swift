import SwiftUI



struct CustomSampleView: View {
    @State var tabContents = [
        SlideTabContent(id: 0, title: "Page1", content: PageView(color: .red)),
        SlideTabContent(id: 1, title: "Page2", content: PageView(color: .green)),
        SlideTabContent(id: 2, title: "Page3", content: PageView(color: .blue))
    ]
        
    var body: some View {
        SlideTabView(tabContents: tabContents)
            .ignoresSafeArea(edges: .bottom)
    }
}

struct PageView: View {
    let color: Color
    
    var body: some View {
        color.ignoresSafeArea()
    }
}

struct CustomSampleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSampleView()
    }
}
