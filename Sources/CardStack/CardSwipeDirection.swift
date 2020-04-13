import Foundation

public enum LeftRight {
    case left, right

    public static func direction(degrees: Double) -> Self? {
        switch degrees {
        case 045..<135: return .right
        case 225..<315: return .left
        default: return nil
        }
    }
}

public enum FourDirections {
    case top, right, bottom, left

    public static func direction(degrees: Double) -> Self? {
        switch degrees {
        case 045..<135: return .right
        case 135..<225: return .bottom
        case 225..<315: return .left
        default: return .top
        }
    }
}
