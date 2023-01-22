//
//  ContentView.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Dial()
                .padding()
        }
        .padding()
    }
}

struct SpokesView: View {
    var body: some View {
        ForEach(0..<360, id:\.self) { index in
            if(Double(index).truncatingRemainder(dividingBy: 2.25) == 0) {
                Rectangle()
                    .frame(width: 1)
                    .rotationEffect(.degrees(Double(index)))
            }
        }
    }
}
struct Dial: View {
    var body: some View {
        ZStack {
            SpokesView()
                .padding(160)
            Circle().fill(Color.white)
                .shadow(color: .gray, radius: 9, x: 8, y: 8)
                .shadow(color: .white, radius: 9, x: -8, y: -8)
            ZStack {
                Circle().fill(Color.white)
                    .shadow(color: .gray, radius: 9, x: 8, y: 8)
                    .shadow(color: .white, radius: 9, x: -8, y: -8)
                Circle().stroke(style: .init(lineWidth: 15))
                    .padding(20)
                    .foregroundColor(.orange.opacity(0.5))
                Circle()
                    .trim(from: 0.4, to: 1.0)
                    .stroke(style: .init(lineWidth: 15))
                    .rotation(.degrees(-90))
                    .padding(20)
                VStack(alignment: .center) {
                    Text("Goal 10,000")
                        .font(.headline)
                    Text("7,540")
                        .font(.largeTitle).bold()
                        .padding()
                    Text("Steps")
                        .font(.headline)
                }
            }
            .padding()
        }.foregroundColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//extension Font {
//    static let productSans = Font.custom("FF", size: 23)
//}
