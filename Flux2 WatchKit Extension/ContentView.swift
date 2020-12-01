//
//  ContentView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var sessionMinutes = 25
    @State var cycles: Double = 2
    
    let sessionTypes = [25, 45]
    
    var body: some View {
        ScrollView{
            HStack{
                ForEach(0..<2) {sessions in
                    VStack{
                        ForEach(0..<3) { number in
                            NavigationLink(destination: TimerView(text: "\(number)")) {
                                VStack {
                                    Group{
                                        Text("\(Int(pow(cycles, Double(number))))x")
                                            .fontWeight(.light)
                                            .font(.footnote)
                                            .padding(.bottom, -7.0)
                                        
                                        Text("\(sessionTypes[sessions])")
                                            .font(.system(size: 30, design: .rounded))
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                            .frame(width: 85, height: 30, alignment: .center)
                                        
                                        Text("MIN")
                                            .fontWeight(.light)
                                            .foregroundColor(Color.white)
                                            .padding(.top, -13.0)
                                    }
                                }
                            }
                            .background(Color.black)
                            .frame(width: 68, height: 68, alignment: .center)
                            .cornerRadius(50)
                            .overlay(Circle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 4,dash: [2])))
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
