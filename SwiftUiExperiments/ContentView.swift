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
extension Double {
    var roundedTwo: String {
        return String(format: "%.2f", self)
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
                    .trim(from: GpaValue.max.rawValue, to: 1.0)
                    .stroke(style: .init(lineWidth: 15, lineCap: .round))
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

enum GpaValue: CGFloat {
    case max = 0.4
}


struct GPAProgressBar: View {
    @State private var color: Color = .red
    var gpa: Double
    let maxGPA = 4.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.4), lineWidth: 8)
            Circle()
                .trim(from: 0, to: gpa / maxGPA)
                .stroke(style: .init(lineWidth: 8, lineCap: .round))
                .scale(x: -1)
                .foregroundColor(color)
                .animation(.easeOut, value: gpa / maxGPA)
                .rotationEffect(.degrees(90))
            VStack {
                Text("\(gpa.roundedTwo)")
                    .foregroundColor(.black)
                    .font(.headline)
                    .bold()
                Text("GPA")
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    .font(.subheadline)
            }.multilineTextAlignment(.center)
                .onAppear {
                    if gpa >= 3.0 {
                        color = .blue
                    } else {
                        color = .red
                    }
                }
        }.frame(maxWidth: 70)
    }
}
struct ItemView: View {
    var body: some View {
        NavigationLink {
            //Destination
            Text("Hi")
        } label: {
            //Component
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("First Semester")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .bold()
                    Text("Maths, Biology, Chemistry")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                Spacer()
                GPAProgressBar(gpa: 2.5)
            }
        }


    }
}
var mData: Dictionary<String,[SavingsDataPoint]> = ["year": [
    .init(month: "First Year", value: 3.80),
    .init(month: "Second Year", value: 2.85),
    .init(month: "Third Year", value: 3.20),
    .init(month: "Fourth Year", value: 3.70)
], "semester": [
    .init(month: "1st yr", value: 3.00, color: "Blue"),
    .init(month: "1st yr", value: 4.00, color: "Yellow"),
    .init(month: "2nd yr", value: 4.00,color: "Blue"),
    .init(month: "2nd yr", value: 3.24, color: "Yellow"),
    .init(month: "3rd yr", value: 3.20, color: "Blue"),
    .init(month: "3rd yr", value: 3.50, color: "Yellow"),
    .init(month: "4th yr", value: 3.90, color: "Yellow")],
                                                    "course": []]
struct SomeView: View {
    @State private var selectedTab = "year"
    let tabs = ["year", "semester", "course"]
    @State private var chartOptions = Options(type: "year", xLabel: "Year (Academic)", yLabel: "CGPA")
    var body: some View {
        NavigationStack {
            ScrollView {
                HeaderView(title: "My Semesters")
                    .padding(.horizontal)
                SegmentedPicker(selectedTab: $selectedTab, data: tabs)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                //MARK: chat view
                MyChartView(data: mData[selectedTab]!, options: $chartOptions)
                    .frame(minHeight: 250)
                    .padding()
                    .animation(.easeInOut, value: selectedTab)
                    .onChange(of: selectedTab) { newValue in
                        if newValue == "semester" {
                            chartOptions.type = newValue
                            chartOptions.xLabel = "All Semesters"
                            chartOptions.yLabel = "GPA"
                        }else if newValue == "year" {
                            chartOptions.type = newValue
                            chartOptions.xLabel = "Year (Academic)"
                            chartOptions.yLabel = "CGPA (per year)"
                        } else {
                            chartOptions.type = newValue
                            chartOptions.xLabel = "All Courses"
                            chartOptions.yLabel = "GPA"
                        }
                    }
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
                            ForEach(0..<2) { i in
                                ItemView()
                                    .padding()
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
        }
        .previewLayout(.sizeThatFits)
    }
}
struct MyView: View {
    @State var gpa:Double = 0
    var body: some View {
        VStack {
            GPAProgressBar(gpa: gpa)
            Slider(value: $gpa, in: 0...4)
        }.padding()
    }
}
struct ContentView_Previews: PreviewProvider {
    @State var max: Double
    static var previews: some View {
        //  ContentView()
        SomeView()
    }
}

//extension Font {
//    static let productSans = Font.custom("FF", size: 23)
//}
