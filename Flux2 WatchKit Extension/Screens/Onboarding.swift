//
//  OnBoardingView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 8/9/21.
//

import SwiftUI

struct Onboarding: View {
    
    var body: some View {
        
        ZStack {
            TabView {
                PageOne()
                PageOne()
                SetGoalView()
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

struct PageOne: View {
    var body: some View {
        VStack {
            Text("Onboarding start here...")
                .font(.title2)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button(action: {
                
            }) {
                ButtonTextStyle(title: "Next")
            }
            .background(Color.brandPrimary)
            .cornerRadius(50)
        }
    }
}
