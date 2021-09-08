//
//  OnBoardingView.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 8/9/21.
//

import SwiftUI

struct OnBoardingView: View {
    
    var body: some View {
        VStack {
            
            Text("Onboarding goes here")
            
            
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


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
