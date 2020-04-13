import SwiftUI
import SnapshotTesting

#if os(iOS)
import UIKit
extension Snapshotting where Value: View, Format == UIImage {
    public static func image(precision: Float = 1.0, size: CGSize) -> Snapshotting {
        Snapshotting<UIViewController, UIImage>
            .image(precision: precision, size: size)
            .pullback(UIHostingController.init(rootView:))
    }
}
#endif

#if os(macOS)
import AppKit
extension Snapshotting where Value: View, Format == NSImage {
    public static func image(precision: Float = 1.0, size: CGSize) -> Snapshotting {
        Snapshotting<NSViewController, NSImage>
            .image(precision: precision, size: size)
            .pullback(NSHostingController.init(rootView:))
    }
}
#endif
