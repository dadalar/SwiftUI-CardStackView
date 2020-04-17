//
//  ContentView.swift
//  Example
//
//  Created by Deniz Adalar on 13/04/2020.
//  Copyright © 2020 Dadalar It Software. All rights reserved.
//

import SwiftUI
import CardStack

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let image: UIImage
    let distance: Int = { .random(in: 1..<20) }()

    static let mock: [Person] = [
        Person(name: "Niall Miller", image: UIImage(named: "1")!),
        Person(name: "Sammy Smart", image: UIImage(named: "2")!),
        Person(name: "Edie Bain", image: UIImage(named: "3")!),
        Person(name: "Gia Velez", image: UIImage(named: "4")!),
        Person(name: "Harri Devine", image: UIImage(named: "5")!),
    ]
}

struct CardView: View {
    let person: Person

    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: self.person.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: geo.size.width)
                    .clipped()
                HStack {
                    Text(self.person.name)
                    Spacer()
                    Text("\(self.person.distance) km away")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    }
}

struct CardViewWithThumbs: View {
    let person: Person
    let direction: LeftRight?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .topLeading) {
                CardView(person: person)
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .foregroundColor(Color.green)
                    .opacity(direction == .right ? 1 : 0)
                    .frame(width: 100, height: 100)
                    .padding()
            }

            Image(systemName: "hand.thumbsdown.fill")
                .resizable()
                .foregroundColor(Color.red)
                .opacity(direction == .left ? 1 : 0)
                .frame(width: 100, height: 100)
                .padding()
        }
        .animation(.default)
    }
}

struct Basic: View {
    @State var data: [Person] = Person.mock

    var body: some View {
        CardStack(
            direction: LeftRight.direction,
            data: data,
            onSwipe: { card, direction in
                print("Swiped \(card.name) to \(direction)")
            },
            content: { person, _, _ in
                CardView(person: person)
            }
        )
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("Basic", displayMode: .inline)
    }
}

struct Thumbs: View {
    @State var data: [Person] = Person.mock

    var body: some View {
        CardStack(
            direction: LeftRight.direction,
            data: data,
            onSwipe: { card, direction in
                print("Swiped \(card.name) to \(direction)")
            },
            content: { person, direction, _ in
                CardViewWithThumbs(person: person, direction: direction)
            }
        )
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("Thumbs", displayMode: .inline)
    }
}

struct AddingCards: View {
    @State var data: [Person] = Array(Person.mock.prefix(2))

    var body: some View {
        CardStack(
            direction: LeftRight.direction,
            data: data,
            onSwipe: { _, _ in
                self.data.append(Person.mock.randomElement()!)
            },
            content: { person, _, _ in
                CardView(person: person)
            }
        )
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("Adding cards", displayMode: .inline)
    }
}

struct ReloadCards: View {
    @State var reloadToken = UUID()
    @State var data: [Person] = Person.mock.shuffled()

    var body: some View {
        CardStack(
            direction: LeftRight.direction,
            data: data,
            onSwipe: { card, direction in
                print("Swiped \(card.name) to \(direction)")
            },
            content: { person, _, _ in
                CardView(person: person)
            }
        )
        .id(reloadToken)
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("Reload cards", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.reloadToken = UUID()
                self.data = Person.mock.shuffled()
            }) {
                Text("Reload")
            }
        )
    }
}

struct CustomDirection: View {
    enum MyDirection {
        case up, down

        static func direction(degrees: Double) -> Self? {
            switch degrees {
            case 315..<360, 0..<45: return .up
            case 135..<225: return .down
            default: return nil
            }
        }
    }

    @State var data: [Person] = Person.mock

    var body: some View {
        CardStack(
            direction: MyDirection.direction,
            data: data,
            onSwipe: { card, direction in
                print("Swiped \(card.name) to \(direction)")
            },
            content: { person, _, _ in
                CardView(person: person)
            }
        )
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("Custom direction", displayMode: .inline)
    }
}

struct CustomConfiguration: View {
    @State var data: [Person] = Person.mock

    var body: some View {
        CardStack(
            direction: LeftRight.direction,
            data: data,
            onSwipe: { card, direction in
                print("Swiped \(card.name) to \(direction)")
            },
            content: { person, _, _ in
                CardView(person: person)
            }
        )
        .environment(\.cardStackConfiguration, CardStackConfiguration(
            maxVisibleCards: 3,
            swipeThreshold: 0.1,
            cardOffset: 40,
            cardScale: 0.2,
            animation: .linear
        ))
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("Custom configuration", displayMode: .inline)
    }
}


struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Basic()) {
                    Text("Basic")
                }
                NavigationLink(destination: Thumbs()) {
                    Text("Thumbs")
                }
                NavigationLink(destination: AddingCards()) {
                    Text("Adding cards")
                }
                NavigationLink(destination: ReloadCards()) {
                    Text("Reload cards")
                }
                NavigationLink(destination: CustomDirection()) {
                    Text("Custom direction")
                }
                NavigationLink(destination: CustomConfiguration()) {
                    Text("Custom configuration")
                }
            }
            .navigationBarTitle("Examples")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
