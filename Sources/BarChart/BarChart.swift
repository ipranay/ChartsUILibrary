//
//  BarChartView.swift
//  
//
//  Created by Pranay Joshi on 2020-08-25.
//

import SwiftUI

public struct BarChartData {
    public var values : [BarChartItem]
    
    public init(_ values : [BarChartItem], hideLabels: Bool = false) {
        self.values = values
    }
    
    public init(_ values : [Float], hideLabels: Bool = false) {
        self.values = values.map({ (floatValue) -> BarChartItem in
            BarChartItem(value: floatValue, label: "\(Int(floatValue))")
        })
    }
    
    public struct BarChartItem : Comparable, Identifiable {
        public var value : Float
        public var label : String

        public var id : Float { value }

        public static func < (lhs: BarChartItem, rhs: BarChartItem) -> Bool {
            lhs.value < rhs.value
        }
    }
}

@available(iOS 14.0.0, OSX 10.15.0, tvOS 13.0.0, watchOS 6.0, *)
public struct BarChartView: View {
    var data : BarChartData
    var color : Color
    var bgColor : Color
    var hideLabels : Bool
    
    public init(data: BarChartData, color: Color = Color.white, bgColor: Color = Color.gray.opacity(0.3), hideLabels: Bool = false) {
        self.data = data
        self.color = color
        self.bgColor = bgColor
        self.hideLabels = hideLabels
    }
    
    public var body: some View {
        VStack(spacing: 2.0) {
            ForEach(data.values) { item in
                BarView(
                    item: item,
                    maxItem: data.values.max()!,
                    color: color,
                    bgColor: bgColor,
                    hideLabel: hideLabels
                ).frame(height: hideLabels ? 7 : 20, alignment: .leading)
            }
        }
    }
}

@available(iOS 14.0.0, OSX 10.15.0, tvOS 13.0.0, watchOS 6.0, *)
struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        let data = BarChartData([Float(5), 10, 20, 5, 3, 12])
        
        return Group {
            BarChartView(data: data, color: Color.blue, bgColor: Color.white.opacity(0), hideLabels: false)
                .preferredColorScheme(.light)

            BarChartView(data: data)
                .preferredColorScheme(.dark)
         }
            .frame(width: 200)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

struct BarView: View {
    let textLength = CGFloat(20.0)
    let spacing = CGFloat(5.0)
    let barThickness = CGFloat(5.0)
    
    var item: BarChartData.BarChartItem
    var maxItem : BarChartData.BarChartItem
    
    var color = Color.white
    var bgColor = Color.gray.opacity(0.3)
    var hideLabel = false
    
    func barLength(_ geometry: GeometryProxy) -> CGFloat {
        CGFloat(item.value * Float(fullLength(geometry)) / maxItem.value)
    }
    
    func fullLength(_ geometry: GeometryProxy) -> CGFloat {
        geometry.size.width - (hideLabel ? 0 : textLength + spacing)
    }
    
    public var body: some View {
        GeometryReader { (geometry) in
            return HStack(spacing: 5.0) {
                if !hideLabel {
                    Text(item.label)
                        .font(.subheadline)
                        .foregroundColor(color)
                        .frame(width: textLength, alignment: .trailing)
                }
                color
                    .frame(width: barLength(geometry), height: barThickness)
                    .cornerRadius(3)
                    .frame(width: fullLength(geometry), height: barThickness, alignment: .leading)
                    .background(bgColor)
                    .cornerRadius(3)
            }.foregroundColor(.gray)
        }
    }
}
