//
//  ChartKindaView.swift
//  SwiftUiExperiments
//
//  Created by dremobaba on 2023/1/23.
//

import SwiftUI
import Charts

enum Tabs: String, CaseIterable {
    case monthly
    case weekly
    case daily
    
}
struct SavingsDataPoint: Identifiable, Hashable {
    var month: String
    var value: Double
    var id = UUID()
    var color: String = "blue"
}
var data: Dictionary<String,[SavingsDataPoint]> = ["monthly": [
      .init(month: "May", value: 4000),
      .init(month: "Jun", value: 9880),
      .init(month: "Jul", value: 6500),
      .init(month: "Aug", value: 5500),
      .init(month: "Sep", value: 9000),
      .init(month: "Oct", value: 3500),
      .init(month: "Nov", value: 3500),
  ], "weekly": [
      .init(month: "Mon", value: 140),
      .init(month: "Tue", value: 980),
      .init(month: "Wed", value: 600),
      .init(month: "Thu", value: 950),
      .init(month: "Fri", value: 900),
      .init(month: "Sat", value: 350),
      .init(month: "Sun", value: 120)],
     "daily": []]

struct ChartKindaView: View {
    @State private var selectedTab = "monthly"
    let tabs = ["monthly", "weekly", "daily"]
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                //MARK: header
                HeaderView(title: "My Spending")
                    .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    //MARK: amount
                    Text("$9,800.00")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    //MARK: break down selector
                    SegmentedPicker(selectedTab: $selectedTab, data: tabs)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    //MARK: chat view
//                    MyChartView(data: data[selectedTab]!)
//                        .frame(minHeight: 250)
//                        .padding()
//                        .animation(.easeInOut, value: selectedTab)
                }
            }
        }
    }
}

struct SegmentedPicker: View {
    @Binding var selectedTab: String
    let data: [String]
    @Namespace var underline
    var body: some View {
        VStack(alignment: .leading) {
            LazyHStack {
                ForEach(data, id: \.self) { tab in
                    Button {
                        withAnimation {
                            selectedTab = tab
                        }
                    } label: {
                        let isSelected = selectedTab == tab
                        VStack(alignment: .leading) {
                            Text(tab.capitalized)
                                .font(.title2)
                                .padding(.horizontal, 10)
                                .padding(.bottom)
                                .foregroundColor(isSelected ? .primary : .secondary)
                        }.overlay(alignment: .bottom) {
                            if isSelected {
                                Rectangle()
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "option", in: underline)
                                    .transition(.scale)
                            }
                        }
                    }.foregroundColor(.black)
                }
            }
            //MARK: TAB DEMARCATION
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.secondary.opacity(0.2))
                .offset(y: -9)
        }
    }
}

struct Options {
    var type: String
    var xLabel: String
    var yLabel: String
}
struct MyChartView: View {
    let data: [SavingsDataPoint]
    @Binding var options: Options
    
    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.element) { index, item in
                let color = index % 2 == 0 ? Color.black : Color.blue
                BarMark(x: .value("Shape Type", item.month),
                        y: .value("Total count", item.value)
                )
                .foregroundStyle(color)
                .annotation(position: .top) {
                    Text(item.value.roundedTwo)
                        .font(.caption)
                }
            }
        }
        .chartForegroundStyleScale(options.type == "semester" ? [
            "1st semester": .black, "2nd semester": .blue
        ] : [:])
        .chartYAxis {
            AxisMarks(position: .leading, values: .stride(by: 1.5)) { value in
                AxisGridLine()
                if let value = value.as(Double.self) {
                    AxisValueLabel(offsetsMarks: true) {
                        Text(value.roundedTwo)
                    }
                }
            }
        }
        .chartYAxisLabel(options.yLabel, position: .trailing, alignment: .center)
        .chartXAxisLabel(options.xLabel, position: .bottom, alignment: .center)
        .chartXAxis {
            AxisMarks(values: .automatic) {
                AxisValueLabel()
            }
        }
        .overlay {
            if data.isEmpty {
                Text("No data")
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
        }
    }
}

struct HeaderView: View {
    let title: String
    var body: some View {
        HStack {
            Button(action:{}) {
                icon(name: "line.3.horizontal")
            }
            Spacer()
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            
            Button(action:{}) {
                icon(name: "magnifyingglass")
            }
        }
    }
    
    @ViewBuilder
    func icon(name: String) -> some View {
        RoundedRectangle(cornerRadius: 6)
            .stroke(.black.opacity(0.2))
            .frame(width: 35, height: 35)
            .overlay {
                Image(systemName: name)
                    .renderingMode(.template)
                    .foregroundColor(.black)
            }
    }
}

struct ChartKindaView_Previews: PreviewProvider {
    static var previews: some View {
       SomeView()
    }
}
