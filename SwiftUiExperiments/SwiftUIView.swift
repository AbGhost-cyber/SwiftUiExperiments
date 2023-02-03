//
//  SwiftUIView.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/2/2.
//

import SwiftUI

struct DemoItem: Identifiable, Equatable {
    var name: String
    var color: Color
    var id: UUID = UUID()
}

struct SwiftUIView: View {
    @State var colors:[DemoItem] = [
        DemoItem(name: "Red", color: .red),
        DemoItem(name: "Orange", color: .orange),
        DemoItem(name: "Yellow", color: .yellow),
        DemoItem(name: "Green", color: .green),
        DemoItem(name: "Mint", color: .mint),
        DemoItem(name: "White", color: .white),
        DemoItem(name: "Brown", color: .brown),
        DemoItem(name: "Pink", color: .pink),
    ]
    
    @State private var currentIndex = 0
    @State private var isBackTrack = false
    @State private var isFinished = false
    @State private var hasStarted = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle().fill(Color.blue.opacity(0.5))
                    .ignoresSafeArea(.all)
                ForEach(colors.indices.reversed(), id: \.self) { index in
                    let relativeIndex = colors.distance(from: currentIndex, to: index)
                    let color = getColor(relativeIndex: relativeIndex)
                    
                    if relativeIndex >= 0 && relativeIndex < 3 {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(color)
                            .overlay(alignment: .bottom) {
                                overlayView(index: index)
                            }
                            .padding(20)
                            .frame(height: geo.size.height / 1.2)
                            .offset(x: 0, y: CGFloat(relativeIndex) * 8)
                            .transition(transition(index: index))
                            .scaleEffect(1 - 0.1 * CGFloat(relativeIndex), anchor: .bottom)
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .overlay {
                if isFinished {
                    Text("GOOD JOB! 😈")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .animation(.easeOut, value: isFinished)
                        .transition(.slide)
                }
            }
        }
    }
    
    private func transition(index: Int) -> AnyTransition {
        if currentIndex == index && hasStarted {
            return .move(edge: .leading)
        } else {
            return .identity
        }
    }
    
    func getColor(relativeIndex: Int) -> Color {
        let color = Color(uiColor: .white)
        if relativeIndex == 0 {
            return color
        } else if relativeIndex == 1 {
            return color.opacity(0.5)
        } else {
            return color.opacity(0.3)
        }
    }
    
    @ViewBuilder
    private func overlayView(index: Int) -> some View {
        if currentIndex == index {
            VStack {
                Text(colors[currentIndex].name)
                    .font(.largeTitle)
                    .bold()
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            isBackTrack = true
                            currentIndex = colors.index(before: index)
                        }
                    } label: {
                        let color = index == 0 ? Color(uiColor: .secondaryLabel) : Color.primary
                        Text("Back")
                            .font(.title2)
                            .foregroundColor(color)
                            .bold()
                            .frame(maxWidth: .infinity)
                    }.disabled(index == 0)

                      Spacer()
                      Button {
                          withAnimation {
                              hasStarted = true
                              isBackTrack = false
                              isFinished = index == colors.count - 1
                              currentIndex = colors.index(after: index)
                          }
                      } label: {
                          Text("Next")
                              .font(.title2)
                              .foregroundColor(.white)
                              .bold()
                              .frame(maxWidth: 200, maxHeight: 65)
                              .background(Color.accentColor)
                              .cornerRadius(10)
                      }


                  }
                  .padding(30)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
