import Foundation

/*

 Degrees will be passed as Double between 0 and 360 where 0 points to top and 180 points to bottom.

           0
           |
           |
           |
  270--------------90
           |
           |
           |
          180

*/

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

public enum EightDirections {
  case top, right, bottom, left, topLeft, topRight, bottomLeft, bottomRight

  public static func direction(degrees: Double) -> Self? {
    switch degrees {
    case 022.5..<067.5: return .topRight
    case 067.5..<112.5: return .right
    case 112.5..<157.5: return .bottomRight
    case 157.5..<202.5: return .bottom
    case 202.5..<247.5: return .bottomLeft
    case 247.5..<292.5: return .left
    case 292.5..<337.5: return .topLeft
    default: return .top
    }
  }
}
