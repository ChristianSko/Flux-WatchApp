//
//  PickerView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/5/21.
//

import SwiftUI

struct PickerView: View {
    @State var startTimerView = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Picker(measureUnit: .cycle)
                Text("x").padding(.horizontal, -4)
                Picker(measureUnit: .minutes)
                Text("").padding(.horizontal, -4)
            }
            .padding(.bottom, 8)
            .edgesIgnoringSafeArea(.horizontal)
        
            Button(action: {
                startTimerView.toggle()
            }) {
                Text("Start")
                    .colorInvert()
            }
            .background(Color.brandPrimary)
            .cornerRadius(20)
            .padding(.vertical, 4)
            .sheet(isPresented: $startTimerView, content: {
                print(Tim)
                
            })
            
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
