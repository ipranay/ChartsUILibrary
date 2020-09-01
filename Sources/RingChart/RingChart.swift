//
//  RingChartView.swift
//  
//
//  Created by Pranay Joshi on 2020-08-28.
//

import SwiftUI

struct RingChartView: View {
    var value : Double
    @State var text : String?
    var color : Color
    
    @State private var show: Bool = false
    
    var displayText : String {
        text ?? "\(Int(value * 100))%"
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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(color.opacity(0.1), style: StrokeStyle(lineWidth: strokeWidth(geometry)))
                
                Circle()
                    .trim(from: 0, to: self.show ? CGFloat(value) : 0)
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

struct RingChartView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State(initialValue: false) var show: Bool

        var body: some View {
            VStack {
                if (show) {
                    RingChartView(value: 0.45, color: Color.blue)
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
