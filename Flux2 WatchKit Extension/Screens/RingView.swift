//
//  RingView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 30/12/20.
//

import SwiftUI

extension Double {
    func toRadians() -> Double {
        return self * Double.pi / 180
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

struct RingShape: Shape {
    // Helper function to convert percent values to angles in degrees
    static func percentToAngle(percent: Double, startAngle: Double) -> Double {
        (percent / 100 * 360) + startAngle
    }
    private var percent: Double
    private var startAngle: Double
    private let drawnClockwise: Bool
    
    // This allows animations to run smoothly for percent values
    var animatableData: Double {
        get {
            return percent
        }
        set {
            percent = newValue
        }
    }
    
    init(percent: Double = 100, startAngle: Double = -90, drawnClockwise: Bool = false) {
        self.percent = percent
        self.startAngle = startAngle
        self.drawnClockwise = drawnClockwise
    }
    
    // This draws a simple arc from the start angle to the end angle
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(width, height) / 2
        let center = CGPoint(x: width / 2, y: height / 2)
        let endAngle = Angle(degrees: RingShape.percentToAngle(percent: self.percent, startAngle: self.startAngle))
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: endAngle, clockwise: drawnClockwise)
        }
    }
}

struct RingView: View {
    
    @AppStorage(UserdefaultKeys.focused) var achievedTime: Double = UserDefaults.standard.double(forKey: UserdefaultKeys.focused)
    @AppStorage(UserdefaultKeys.goal) var objectiveTime = UserDefaults.standard.double(forKey: UserdefaultKeys.goal)
    @State var percentageTime: Double = 0

    
    private static let ShadowColor: Color = Color.black.opacity(0.2)
    private static let ShadowRadius: CGFloat = 5
    private static let ShadowOffsetMultiplier: CGFloat = ShadowRadius + 2
    
    private let ringWidth: CGFloat
    private let percent: Double
    private let backgroundColor: Color
    private let foregroundColors: [Color]
    private let startAngle: Double = -90
    private var gradientStartAngle: Double {
        self.percent >= 100 ? relativePercentageAngle - 360 : startAngle
    }
    private var absolutePercentageAngle: Double {
        RingShape.percentToAngle(percent: self.percent, startAngle: 0)
    }
    private var relativePercentageAngle: Double {
        // Take into account the startAngle
        absolutePercentageAngle + startAngle
    }
    private var firstGradientColor: Color {
        self.foregroundColors.first ?? .black
    }
    private var lastGradientColor: Color {
        self.foregroundColors.last ?? .black
    }
    private var ringGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: self.foregroundColors),
            center: .center,
            startAngle: Angle(degrees: self.gradientStartAngle),
            endAngle: Angle(degrees: relativePercentageAngle)
        )
    }
    
    init(ringWidth: CGFloat, percent: Double, backgroundColor: Color, foregroundColors: [Color]) {
        self.ringWidth = ringWidth
        self.percent = percent
        self.backgroundColor = backgroundColor
        self.foregroundColors = foregroundColors
    }
    
    
    var body: some View {
         
        GeometryReader { geometry in
            ZStack {
                // Background for the ring
                RingShape()
                    .stroke(style: StrokeStyle(lineWidth: self.ringWidth))
                    .fill(self.backgroundColor)
                    .opacity(0.1)
                // Foreground
                RingShape(percent: achievedTime/objectiveTime, startAngle: self.startAngle)
                    .stroke(style: StrokeStyle(lineWidth: self.ringWidth, lineCap: .round))
                    .fill(self.ringGradient)
                // End of ring with drop shadow
                if self.getShowShadow(frame: geometry.size) {
                    Circle()
                        .fill(self.lastGradientColor)
                        .frame(width: self.ringWidth, height: self.ringWidth, alignment: .center)
                        .offset(x: self.getEndCircleLocation(frame: geometry.size).0,
                                y: self.getEndCircleLocation(frame: geometry.size).1)
                        .shadow(color: RingView.ShadowColor,
                                radius: RingView.ShadowRadius,
                                x: self.getEndCircleShadowOffset().0,
                                y: self.getEndCircleShadowOffset().1)
                }
                
                VStack{
                    
                    Text("\(achievedTime/objectiveTime, specifier: "%.2f")%")
                        .font(.system(.body,design: .rounded))
                        .fontWeight(.light)
                    
                    
                    Text("Focus achieved")
                        .font(.system(.body,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.brandPrimary)
        
                    Text("\(Int(achievedTime)) of \(Int(objectiveTime))Min")
                        .font(.system(.body,design: .rounded))
                        .fontWeight(.light)
                }
            }
        }
        .navigationBarTitle("Daily")
        // Padding to ensure that the entire ring fits within the view size allocated
        .padding(self.ringWidth / 2)
    }
    
    private func getEndCircleLocation(frame: CGSize) -> (CGFloat, CGFloat) {
        // Get angle of the end circle with respect to the start angle
        let angleOfEndInRadians: Double = relativePercentageAngle.toRadians()
        let offsetRadius = min(frame.width, frame.height) / 2
        return (offsetRadius * cos(angleOfEndInRadians).toCGFloat(), offsetRadius * sin(angleOfEndInRadians).toCGFloat())
    }
    
    private func getEndCircleShadowOffset() -> (CGFloat, CGFloat) {
        let angleForOffset = absolutePercentageAngle + (self.startAngle + 90)
        let angleForOffsetInRadians = angleForOffset.toRadians()
        let relativeXOffset = cos(angleForOffsetInRadians)
        let relativeYOffset = sin(angleForOffsetInRadians)
        let xOffset = relativeXOffset.toCGFloat() * RingView.ShadowOffsetMultiplier
        let yOffset = relativeYOffset.toCGFloat() * RingView.ShadowOffsetMultiplier
        return (xOffset, yOffset)
    }
    
    private func getShowShadow(frame: CGSize) -> Bool {
        let circleRadius = max(frame.width, frame.height) / 2
        let remainingAngleInRadians = (360 - absolutePercentageAngle).toRadians().toCGFloat()
        if self.percent >= 100 {
            return true
        } else if circleRadius * remainingAngleInRadians <= self.ringWidth {
            return true
        }
        return false
    }
}


struct PercentageRing_Previews: PreviewProvider {
    static var previews: some View {
        RingView(ringWidth: 15, percent: 1, backgroundColor: Color.brandPrimary, foregroundColors: [.white, Color.brandPrimary])
    }
}
