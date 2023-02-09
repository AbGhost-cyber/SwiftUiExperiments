//
//  CategoriesView.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/2/6.
//

import SwiftUI


struct CategoriesView: View {
    private var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(0..<10, id: \.self) { i in
                        GeometryReader { geo in
                            NavigationLink {
                                Text("Hello")
                            } label: {
                                gridLayout(size: geo.size.width)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            .navigationTitle("Trivia App")
        }
            
    }
    
    private func gridLayout (size: Double) -> some View {
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: "books.vertical.fill")
                    .imageScale(.large)
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color(uiColor: .white))
                Text("Arts & Literature")
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .frame(width: size, height: size)
            .background(Color.accentColor)
            .cornerRadius(12)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
