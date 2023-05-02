import SwiftUI
import CoreGraphics

extension View {
    func getRect()->CGRect {
#if os(iOS)
        return UIScreen.main.bounds
#else
        return NSScreen.main!.visibleFrame
#endif
    }
    
#if os(iOS)
    func getSafeArea()->UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
#endif
    
    func isMacOS()->Bool {
#if os(macOS)
        return true
#else
        return false
#endif
    }
    
    func isIOS()->Bool {
#if os(iOS)
        return true
#else
        return false
#endif
    }
    
    func isBigDevice()->Bool {
        return getRect().width > 1000
    }
}

#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
}
#endif
