//
//  CardStack.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/2/4.
//

import SwiftUI

struct CardProps {
    var currentIndex: Int = 0
    //var isBackTracking: Bool = false
    var hasReachedEnd: Bool = false
    var maxCardsToDisplay = 3
}
struct CardStack: View {
    @State private var colors:[DemoItem] = [
        DemoItem(name: "Red", color: .red),
        DemoItem(name: "Orange", color: .orange),
        DemoItem(name: "Yellow", color: .yellow),
        DemoItem(name: "Green", color: .green),
        DemoItem(name: "Mint", color: .mint),
        DemoItem(name: "Teal", color: .teal),
        DemoItem(name: "Brown", color: .brown),
        DemoItem(name: "Pink", color: .pink),
    ]
    
    @State private var props: CardProps = CardProps()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .ignoresSafeArea(.all)
                ForEach(colors.indices.reversed(), id: \.self) { index in
                    let relativeIndex = colors.distance(from: props.currentIndex, to: index)
                    if relativeIndex >= 0 && relativeIndex < props.maxCardsToDisplay {
                        card(index: index, geo: geo, relativeIndex: relativeIndex)
                    }
                }
            }
            .overlay {
                if props.hasReachedEnd {
                    Text("Restart 🫰🏾")
                        .foregroundColor(.white)
                        .font(.title3)
                        .frame(width: 120, height: 65)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                        .transition(.move(edge: .bottom))
                        .onTapGesture {
                            props.hasReachedEnd = false
                            props.currentIndex = 0
                        }
                }
            }
        }
        .navigationTitle("Card Stack")
    }
    
    @ViewBuilder
    private func card(index: Int, geo: GeometryProxy, relativeIndex: Int) -> some View {
        RoundedRectangle(cornerRadius: 20, style: .circular)
            .fill(colors[index].color)
            .padding()
            .frame(height: geo.size.height / 1.2)
            .offset(x: 0, y: CGFloat(relativeIndex) * 8)
            .scaleEffect(1 - 0.1 * CGFloat(relativeIndex), anchor: .bottom)
            .transition(.asymmetric(
                insertion: .identity, removal: .move(edge: .leading)))
            .onTapGesture {
                withAnimation(Animation.easeOut(duration: 0.3)) {
                    props.hasReachedEnd = index == colors.count - 1
                    props.currentIndex = colors.index(after: index)
                }
            }
    }
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CardStack()
        }
    }
}

