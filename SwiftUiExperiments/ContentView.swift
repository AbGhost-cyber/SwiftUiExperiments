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

struct ProgressBar: View {
    let color: Color
    let text: String
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.4), lineWidth: 10)
            Circle()
                .trim(from: 0.3, to: 1.0)
                .stroke(color, lineWidth: 10)
                .rotationEffect(.degrees(-90))
            VStack {
                Text(text)
                    .foregroundColor(.accentColor)
                    .font(.headline)
                    .frame(width: .infinity, alignment: .center)
                    .bold()
            }
        }
    }
}
struct ItemView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("First Semester")
                    .font(.headline)
                    .bold()
                Text("Maths, Biology, Chemistry")
                    .font(.subheadline)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            ProgressBar(color: .red, text: "2.40")
                .padding([.leading])
                .frame(width: 90, height: 60, alignment: .trailing)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       // ContentView()
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Recent").bold()
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("View All")
                        Image(systemName: "chevron.right")
                    }

                }
                .padding()
                ForEach(0..<2) { j in
                    Section {
                        VStack {
                            ForEach(0..<3) { i in
                                ItemView()
                                Divider()
                                    .opacity(i == 9 ? 0: 1)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3)))
                        .padding([.leading, .trailing])
                        .padding(.bottom, 10)
                    } header: {
                        Text("FIRST YEAR")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.caption)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                            .padding(.leading)
                    }
                }
            }
            .navigationTitle("Semesters")
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                    }

                }
            }
        }
        .previewLayout(.sizeThatFits)
    }
}

//extension Font {
//    static let productSans = Font.custom("FF", size: 23)
//}
