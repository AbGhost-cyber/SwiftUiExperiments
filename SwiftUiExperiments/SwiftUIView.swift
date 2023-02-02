//
//  SwiftUIView.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/2/2.
//

import SwiftUI

struct DemoItem: Identifiable {
    var name: String
    var color: Color
    var id: UUID = UUID()
}

struct SwiftUIView: View {
    let colors = [
        DemoItem(name: "Red", color: .red),
        DemoItem(name: "Orange", color: .orange),
        DemoItem(name: "Yellow", color: .yellow),
//        DemoItem(name: "Green", color: .green),
//        DemoItem(name: "Blue", color: .blue),
//        DemoItem(name: "Purple", color: .purple)
    ]
    @State private var translation: CGSize = .zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle().fill(Color.blue.opacity(0.5))
                    .ignoresSafeArea(.all)
                ForEach(colors.indices.reversed(), id: \.self) { index in
                    let namedColor = colors[index]
                    let color = index == 0 ? Color.white : Color.white.opacity(index == 1 ? 0.5 : 0.3)
                    let relativeIndex = colors.distance(from: 0, to: index)
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(color)
                        .overlay(alignment: .bottom, content: {
                            if index == 0 {
                                HStack {
                                    Button {
                                        
                                    } label: {
                                        Text("Back")
                                            .font(.title2)
                                            .foregroundColor(.black)
                                            .bold()
                                            .frame(maxWidth: .infinity)
                                    }

                                    Spacer()
                                    Button {
                                        
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

                        })
                        .overlay {
                            Text(namedColor.name)
                                .font(.largeTitle)
                                .bold()
                        }
                        .padding(20)
                        .frame(height: geo.size.height / 1.2)
                        .offset(x: 0, y: CGFloat(relativeIndex) * 10)
                        .scaleEffect(
                            1 - 0.1 * CGFloat(relativeIndex),
                            anchor: .bottom
                        )
                    
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
