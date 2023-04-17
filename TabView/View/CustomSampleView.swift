import SwiftUI



struct CustomSampleView: View {
    @State var tabViewTypes = [
        SlideTabContent(id: 0, title: "Page1", view: AnyView(PageView(color: .red))),
        SlideTabContent(id: 1, title: "Page2", view: AnyView(PageView(color: .green))),
        SlideTabContent(id: 2, title: "Page3", view: AnyView(PageView(color: .blue)))
    ]
        
    var body: some View {
        SlideTabView(tabContents: tabViewTypes)
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
