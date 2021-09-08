//
//  SetGoalView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 7/12/20.
//

import SwiftUI

struct SetGoalView: View {
    
    @State var goalTime = UserDefaults.standard.double(forKey: UserdefaultKeys.goal)
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // Need to verify this works
//    @AppStorage(UserdefaultKeys.passedOnboarding) var onBoardingPassed = UserDefaults.standard.bool(forKey: UserdefaultKeys.passedOnboarding)
    @State var onBoardingPassed = false
    
    var body: some View {
        VStack(spacing: 25){

            Text("DAILY FOCUS GOAL")
                .font(.system(size: 16, design: .rounded))
                .fontWeight(.light)
                .foregroundColor(Color.brandPrimary)
            
            VStack{
                HStack {
                    Button(action: {
                        if self.goalTime > 0 {
                            self.goalTime -= 5
                            print(goalTime)
                         }
                    }) {
                        changeAmountButtonView(imageName: SFSymbols.minus)
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.brandPrimary)
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
                        changeAmountButtonView(imageName: SFSymbols.plus)
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(Color.brandPrimary)
                    .cornerRadius(50)
                }
                
                Text("MINUTES")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.brandPrimary)
                    .padding(.top, -5.0)
            }
            
            Button(action: {
                UserDefaults.standard.set(self.goalTime, forKey: UserdefaultKeys.goal)
                self.mode.wrappedValue.dismiss()
                
            }) {
                ButtonTextStyle(title: onBoardingPassed ? "Update" : "Save")
            }
            .background(Color.brandPrimary)
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
            .background(Color.brandPrimary)
            .cornerRadius(50)
        
    }
}
