//
//  ButtonTextStyle.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 30/12/20.
//

import SwiftUI

struct ButtonTextStyle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.body)
            .fontWeight(.light)
            .foregroundColor(.black)
            
    }
}

struct ButtonTextStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTextStyle(title: "Test")
    }
}
