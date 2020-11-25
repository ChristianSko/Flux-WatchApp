//
//  ContentView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationLink(destination: TimerView()) {
            VStack {
                Group{
                    Text("")
                        .fontWeight(.light)
                        .font(.footnote)
                        .padding(.bottom, -7.0)
                    
                    Text("25")
                        .font(.system(size: 30, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .frame(width: 85, height: 30, alignment: .center)
                    
                    Text("MIN")
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .padding(.top, -10.0)
                    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
