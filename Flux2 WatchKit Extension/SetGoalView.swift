//
//  SetGoalView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 7/12/20.
//

import SwiftUI

struct SetGoalView: View {
    
    @State var goalTime = UserDefaults.standard.double(forKey: "Goal")
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 25){

            Text("DAILY FOCUS GOAL")
                .font(.system(size: 16, design: .rounded))
                .fontWeight(.light)
                .foregroundColor(.blue)
            
            VStack{
                HStack {
                    Button(action: {
                        if self.goalTime > 0 {
                            self.goalTime -= 5
                            print(goalTime)
                         }
                    }) {
                        changeAmountButtonView(imageName: "minus")
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(50)
                    
                    Text("\(Int(goalTime))")
                        .font(.system(size: 45, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .frame(width: 85, height: 30, alignment: .center) // to review
                        .layoutPriority(1) //to review
                        .focusable(true)
                        .digitalCrownRotation($goalTime, from: 0, through: 990, by: 5, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
                    
                    
                    
                    Button(action: {
                        if self.goalTime < 991 {
                           self.goalTime += 5
                            print(goalTime)
                        }
                    }) {
                        changeAmountButtonView(imageName: "plus")
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(50)
                }
                
                Text("MINUTES")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, -5.0)
            }
            
            Button(action: {
                UserDefaults.standard.set(self.goalTime, forKey: "Goal")
                self.mode.wrappedValue.dismiss()
                
            }) {
            ButtonTextStyle(title: "Update")
            }
            .background(Color.blue)
            .cornerRadius(50)
            
            
        }
        
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView()
    }
}

struct changeAmountButtonView: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(.black)
            .font(Font.body.weight(.heavy))
            .frame(width: 35, height: 35, alignment: .center)
            .background(Color.blue)
            .cornerRadius(50)
        
    }
}
