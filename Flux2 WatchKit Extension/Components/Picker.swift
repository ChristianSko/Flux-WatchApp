//
//  Picker.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/5/21.
//

import SwiftUI

struct TimePicker: View {

    var measureUnit: MeasureUnitType
    
    @State var selection = 1
    
    var body: some View {
        // The body of TimePicker. Interesting things take place here! ⛳️
        Picker(selection: $selection,
               label: Text(measureUnit.rawValue)

                .font(.system(size: 10)).fontWeight(.bold)
                .minimumScaleFactor(0.001)
                .padding(.horizontal, 3)
                .colorInvert().background(/*@START_MENU_TOKEN@*/Color.green/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .scaledToFill())
        {
            ForEach (measureUnit.indices, id:\.self) { idx in

                Text(self.measureUnit.values[idx])
            }.foregroundColor(.secondary)
        }
        .pickerStyle(WheelPickerStyle())
    }
}

struct TimePicker_Preview: PreviewProvider {
    static var previews: some View {
        TimePicker(measureUnit: .cycle)
            .frame(width: 60)
    }
}
