import XCTest
import CardStack

final class DirectionTests: XCTestCase {

    func testLeftRight() {
        func assertDirection(_ degrees: Double, _ direction: LeftRight?) {
            XCTAssertEqual(LeftRight.direction(degrees: degrees), direction)
        }

        assertDirection(0, nil)
        assertDirection(90, .right)
        assertDirection(180, nil)
        assertDirection(270, .left)
    }

    func testFourDirections() {
        func assertDirection(_ degrees: Double, _ direction: FourDirections?) {
            XCTAssertEqual(FourDirections.direction(degrees: degrees), direction)
        }

        assertDirection(0, .top)
        assertDirection(90, .right)
        assertDirection(180, .bottom)
        assertDirection(270, .left)
    }

    func testEightDirections() {
        func assertDirection(_ degrees: Double, _ direction: EightDirections?) {
            XCTAssertEqual(EightDirections.direction(degrees: degrees), direction)
        }

        assertDirection(0, .top)
        assertDirection(45, .topRight)
        assertDirection(90, .right)
        assertDirection(135, .bottomRight)
        assertDirection(180, .bottom)
        assertDirection(225, .bottomLeft)
        assertDirection(270, .left)
        assertDirection(315, .topLeft)
    }

}
