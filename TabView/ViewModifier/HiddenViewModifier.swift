import SwiftUI

/// 条件に応じてViewを非表示にするViewModifier
struct HiddenViewModifier: ViewModifier {
    var isHidden: Bool
    
    func body(content: Content) -> some View {
        if isHidden {
            content.hidden()
        } else {
            content
        }
    }
}

extension View {
    func hidden(isHidden: Bool) -> some View {
        modifier(HiddenViewModifier(isHidden: isHidden))
    }
}
