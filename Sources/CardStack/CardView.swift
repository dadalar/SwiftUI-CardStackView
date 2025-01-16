import SwiftUI
import Combine

struct CardView<Direction, Content: View>: View {
  @Environment(\.cardStackConfiguration) private var configuration: CardStackConfiguration
  @State private var translation: CGSize = .zero
  @State private var draggingState: CardDraggingState = .idle
  @GestureState private var isDragging: Bool = false

  private let direction: (Double) -> Direction?
  private let isOnTop: Bool
  private let onSwipe: (Direction) -> Void
  private let content: (Direction?) -> Content

  private enum CardDraggingState {
    case dragging
    case ended
    case idle
  }

  init(
    direction: @escaping (Double) -> Direction?,
    isOnTop: Bool,
    onSwipe: @escaping (Direction) -> Void,
    @ViewBuilder content: @escaping (Direction?) -> Content
  ) {
    self.direction = direction
    self.isOnTop = isOnTop
    self.onSwipe = onSwipe
    self.content = content
  }

  @ViewBuilder var cardView: some View {
    GeometryReader { geometry in
      self.content(self.swipeDirection(geometry))
        .disabled(self.translation != .zero)
        .offset(self.translation)
        .rotationEffect(self.rotation(geometry))
        .simultaneousGesture(self.isOnTop ? self.dragGesture(geometry) : nil)
        .animation(draggingState == .dragging ? .easeInOut(duration: 0.05) : self.configuration.animation, value: translation)
    }
    .transition(transition)
  }

  private func cancelDragging() {
    draggingState = .idle
    translation = .zero
  }

  var body: some View {
    if #available(iOS 14.0, *) {
      cardView
      .onChange(of: isDragging) { newValue in
        if !newValue && draggingState == .dragging {
          cancelDragging()
        }
      }
    } else { // iOS 13.0, *
      cardView
        .onReceive(Just(isDragging)) { newValue in
          if !newValue && draggingState == .dragging {
            cancelDragging()
          }
        }
    }
  }

  private func dragGesture(_ geometry: GeometryProxy) -> some Gesture {
    DragGesture()
      .updating($isDragging) { value, state, transaction in
        state = true
      }
      .onChanged { value in
        self.draggingState = .dragging
        self.translation = value.translation
      }
      .onEnded { value in
        draggingState = .ended
        if let direction = self.swipeDirection(geometry) {
          self.translation = value.translation
          withAnimation(self.configuration.animation) {
            self.onSwipe(direction)
          }
        } else {
          cancelDragging()
        }
      }
  }

  private var degree: Double {
    var degree = atan2(translation.width, -translation.height) * 180 / .pi
    if degree < 0 { degree += 360 }
    return Double(degree)
  }

  private func rotation(_ geometry: GeometryProxy) -> Angle {
    .degrees(
      Double(translation.width / geometry.size.width) * 25
    )
  }

  private func swipeDirection(_ geometry: GeometryProxy) -> Direction? {
    guard let direction = direction(degree) else { return nil }
    let threshold = min(geometry.size.width, geometry.size.height) * configuration.swipeThreshold
    let distance = hypot(translation.width, translation.height)
    return distance > threshold ? direction : nil
  }

  private var transition: AnyTransition {
    .asymmetric(
      insertion: .identity,  // No animation needed for insertion
      removal: .offset(x: translation.width * 2, y: translation.height * 2)  // Go out of screen when card removed
    )
  }
}
