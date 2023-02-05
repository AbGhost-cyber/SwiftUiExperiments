//
//  CardStack.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/2/4.
//

import SwiftUI

struct CardProps {
    var currentIndex: Int = 0
    var isBackTracking: Bool = false
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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var props: CardProps = CardProps()
    
    var body: some View {
        GeometryReader { geo in
            ProgressView(value: Double(props.currentIndex), total: Double(colors.count))
                .progressViewStyle(.linear)
                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                .padding()
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
        .navigationTitle("\(props.currentIndex) of \(colors.count)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    
                } label: {
                    Text("Skip")
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func card(index: Int, geo: GeometryProxy, relativeIndex: Int) -> some View {
        RoundedRectangle(cornerRadius: 20, style: .circular)
            .fill(getColor(relativeIndex: relativeIndex))
            .padding()
            .frame(height: geo.size.height / 1.1)
            .overlay {
                if props.currentIndex == index {
                    VStack(alignment: .leading) {
                        Text("Select an answer")
                            .foregroundColor(!isDark ? .white.opacity(0.5) : .gray)
                            .bold()
                        Text("What do people mean when type the letters 'FTW' in a message on the internet?")
                            .foregroundColor(isDark ? .black : .white)
                            .font(.title2)
                            .bold()
                            .padding(.top, 10)
                        answersView
                        HStack {
                            Button {
                                guard props.currentIndex > 0 else { return }
                                withAnimation(Animation.easeOut(duration: 0.35)) {
                                    props.currentIndex = colors.index(before: index)
                                    props.isBackTracking = true
                                }
                            } label: {
                                Text("Back")
                                    .foregroundColor(isDark ? .black : .white)
                                    .font(.title2)
                                    .frame(width: 120, height: 65)
                                    .bold()
                            }
                            Spacer()
                            Button {
                                withAnimation(Animation.easeIn(duration: 0.35)) {
                                    props.isBackTracking = false
                                    props.hasReachedEnd = index == colors.count - 1
                                    props.currentIndex = colors.index(after: index)
                                }
                            } label: {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .bold()
                                    .frame(width: geo.size.width / 2.5, height: 65)
                                    .background(Color.accentColor)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.top, 40)
                    }
                    .padding(40)
                }
            }
            .offset(x: 0, y: CGFloat(relativeIndex) * 8)
            .scaleEffect(1 - 0.1 * CGFloat(relativeIndex), anchor: .bottom)
            .transition(.asymmetric(insertion: props.isBackTracking ? .move(edge: .leading) :
                .identity, removal: .move(edge: .leading)))
    }
    private var isDark: Bool {
        return colorScheme == .dark
    }
    
    private var answersView: some View {
        ForEach(0..<4) { i in
            RoundedRectangle(cornerRadius: 10)
                .stroke(!isDark ? .white.opacity(0.5) : .gray, lineWidth: 3)
                .frame(height: 70)
                .padding(5)
                .overlay {
                    let text = i + 1 == 4 ? "\(i + 1) and more" : "\(i + 1)"
                    HStack {
                        Image(systemName: i == 3 ? "checkmark.circle.fill": "circle")
                            .symbolRenderingMode(.monochrome)
                            .foregroundColor(isDark ? .black : .white)
                        Text(text)
                            .foregroundColor(isDark ? .black : .white)
                            .bold()
                        Spacer()
                    }
                    .padding(20)
                }
        }
    }
    
    func getColor(relativeIndex: Int) -> Color {
        let color = isDark ? Color.white : Color.black
        if relativeIndex == 0 {
            return color
        } else if relativeIndex == 1 {
            return color.opacity(0.5)
        } else {
            return color.opacity(0.3)
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

