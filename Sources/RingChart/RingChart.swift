//
//  RingChartView.swift
//  
//
//  Created by Pranay Joshi on 2020-08-28.
//

import SwiftUI

@available(iOS 14.0.0, OSX 10.15.0, tvOS 13.0.0, watchOS 6.0, *)
public struct RingChartView: View {
    let data : Double
    let text : String?
    let color : Color
    
    @State private var show: Bool = false
    
    var displayText : String {
        text ?? "\(Int(data * 100))%"
    }
    
    public init(data: Double, color: Color = Color.blue, text: String? = nil) {
        self.data = data
        self.color = color
        self.text = text
    }
    
    func multiplier(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 44
    }
    
    func strokeWidth(_ geometry: GeometryProxy) -> CGFloat {
        return 5.0 * multiplier(geometry)
    }
    
    func shadowRadius(_ geometry: GeometryProxy) -> CGFloat {
        return 3.0 * multiplier(geometry)
    }
    
    func fontSize(_ geometry: GeometryProxy) -> CGFloat {
        return 12.0 * multiplier(geometry)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(color.opacity(0.1), style: StrokeStyle(lineWidth: strokeWidth(geometry)))
                
                Circle()
                    .trim(from: 0, to: self.show ? CGFloat(data) : 0)
                    .stroke(color, style: StrokeStyle(lineWidth: strokeWidth(geometry), lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .shadow(color: color.opacity(0.2), radius: shadowRadius(geometry), x: 0, y: 3)
                
                Text(displayText)
                    .font(.system(size: fontSize(geometry)))
                    .fontWeight(.bold)
            }
            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
        }.onAppear(){
            self.show = true
        }.onDisappear() {
            self.show = false
        }
    }
}

@available(iOS 14.0.0, OSX 10.15.0, tvOS 13.0.0, watchOS 6.0, *)
struct RingChartView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State(initialValue: false) var show: Bool

        var body: some View {
            VStack {
                if (show) {
                    RingChartView(data: 0.45)
                        .frame(width: 300, height: 300)
                        .animation(Animation.spring(response: 0.5, dampingFraction: 0.6).delay(0.2))
                        .onTapGesture() {
                            show.toggle()
                        }
                } else {
                    Button("Show Progress") {
                        show.toggle()
                    }
                }
            }
        }
    }
}
