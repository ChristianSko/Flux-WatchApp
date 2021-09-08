//
//  ContentView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 25/11/20.
//

import SwiftUI

struct SessionView: View {
    @State var sessionMinutes = 25
    @State var cycles: Double = 2
    
    //Sheets go here
    @State var showSetGoalView = false
    @State var showPickerView = false
    @State var showWeeklySummary = false
    
    let sessionTypes = [1, 45]
    let myButtonCornerRadius: CGFloat = 13
    
    var body: some View {
        ScrollView{
            HStack{
                ForEach(0..<2) {sessions in
                    VStack{
                        ForEach(0..<3) { number in
                            NavigationLink(destination: TimerView(totalCyles: Int(pow(cycles, Double(number))), session: sessionTypes[sessions] * 60, completedSessionTime: sessionTypes[sessions])) {
                                SessionButton(sessionCycles: Int(pow(cycles, Double(number))), sessionTime: sessionTypes[sessions], timeType: "min")
                            }
                            .background(Color.black)
                            .frame(width: 74, height: 74, alignment: .center)
                            .cornerRadius(50)
                            .overlay(Circle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 4,dash: [2])))
                            .padding()
                        }
                    }
                }
            }
            VStack{
                Button(action: {
                    showPickerView.toggle()
                }, label: {
                    ButtonView(buttonName: "Personalize",
                               imageName: SFSymbols.hourglass)
                })
                .cornerRadius(myButtonCornerRadius)
                .sheet(isPresented: $showPickerView, content: {
                    PickerView()
                })
                
                
                Button(action: {
                    self.showSetGoalView.toggle()
                }, label: {
                    ButtonView(buttonName: "Change Goal",
                               imageName: SFSymbols.downUpArrows)
                })
                .cornerRadius(myButtonCornerRadius)
                .sheet(isPresented: $showSetGoalView, content: {
                    SetGoalView()
                })
//Mark: - Future Feature 
                
                Button(action: {
                    showWeeklySummary.toggle()
                }, label: {
                    ButtonView(buttonName: "Weekly Summary",
                               imageName: SFSymbols.weeklyCalendar)
                })
                .cornerRadius(myButtonCornerRadius)
                .sheet(isPresented: $showWeeklySummary, content: {
                    WeeklySummaryView()
                })

            }
        }
        .navigationBarTitle("Session")
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(sessionMinutes: 1, cycles: 2, showSetGoalView: false)
    }
}

struct SessionButton: View {
    var sessionCycles: Int
    var sessionTime: Int
    var timeType: String
    
    
    var body: some View {
        VStack {
            Group{
                Text("\(sessionCycles)x")
                    .fontWeight(.light)
                    .font(.footnote)
                    .padding(.bottom, -7.0)
                
                Text("\(sessionTime)")
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.brandPrimary)
                    .frame(width: 85, height: 30, alignment: .center)
                
                
                Text(timeType)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .padding(.top, -10.0)
            }
        }
    }
}


struct ButtonView: View {
    var buttonName: String
    var imageName: String
    

    var body: some View {
        HStack(){
            Image(systemName: imageName)
            Text(buttonName)
                .font(.body)
                .multilineTextAlignment(.leading)
                
           Spacer()
        }
    }
}
