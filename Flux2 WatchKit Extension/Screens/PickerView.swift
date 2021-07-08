//
//  PickerView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/5/21.
//

import SwiftUI

struct PickerView: View {
    
    @State var startTimerView = false
    @State var selectedCycle: Int = 1
    @State var selectedMinutesAmount: Int = 1
    
    let cycleInt: [Int] = Array(1...12)
    let minsInt: [Int] = Array(1...60)
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                PickerF(label: "Cycles", unit: cycleInt, selected: $selectedCycle)
                PickerF(label: "Minutes", unit: minsInt, selected: $selectedMinutesAmount)
            }
            .padding(.bottom, 8)
            .edgesIgnoringSafeArea(.horizontal)
        
            Button(action: {
                startTimerView.toggle()
                print(selectedCycle)
                print(selectedMinutesAmount * 60)
            }) {
                Text("Start")
                    .colorInvert()
            }
            .background(Color.brandPrimary)
            .cornerRadius(20)
            .padding(.vertical, 4)
            .sheet(isPresented: $startTimerView, content: {
                TimerView(totalCyles: selectedCycle, session: selectedMinutesAmount * 60, completedSessionTime: selectedMinutesAmount)
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
