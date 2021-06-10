//
//  Picker.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/5/21.
//

import SwiftUI

import SwiftUI

/*
 Here is declared a customized picker 🎳
 It works for picking hours, minutes or seconds ⏰
 Welcome to the "TimePicker.swift"
 
 The TimePicker struct is used in "PickerView.swift", have a look on it! 🤖
 |
 |
 V
 */

struct TimePicker: View {
    
    /* 📐 The MeasureUnitType is a Type defined in
    "MeasureUnit.swift" in the "Model" folder.
    Have a look on it!*/
    var measureUnit: MeasureUnitType
    
    /*
     @State property wrapper! 🎁
     Here is a PRIVATE property, so it belongs to the TimePicker only!
     It is initialised to 1, why? try to change it to another Int number and see what happens
     */
    @State private var selection = 1
    
    var body: some View {
        // The body of TimePicker. Interesting things take place here! ⛳️
        Picker(selection: $selection,
               label: Text(measureUnit.rawValue)
                /*
                 Look at that! 👀 a new Picker is created!
                 "$selection" connects the property to the new Picker.
                 SwiftUI will change its value for us while the picker is rotating!
                 
                 ⚠️ ATTENTION: Following you see the Modifiers of the Text LABEL of the Picker!
                 BTW: what if you put the modifier .colorInvert() after .background(Color.green)?
                 */
                .font(.system(size: 10)).fontWeight(.bold)
                .minimumScaleFactor(0.001)
                .padding(.horizontal, 3)
                .colorInvert().background(/*@START_MENU_TOKEN@*/Color.green/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .scaledToFill())
        {
            ForEach (measureUnit.indices, id:\.self) { idx in
                //  ForEach index of the choosen measurement unit create a view with...
                Text(self.measureUnit.values[idx])
            }.foregroundColor(.secondary)
            // Isn't "ForEach" Powerful? OPT+Click on it to understand what it is.
        }
        .pickerStyle(WheelPickerStyle())
        /*
         Above you see the only modifier we edited for the Picker - the "pickerStyle".
         The WheelPickerStyle hides the scroll bar of Picker that usually is shown when we use the DigitalCrown 👑
         */
    }
}

struct TimePicker_Preview: PreviewProvider {
    static var previews: some View {
        TimePicker(measureUnit: .cycle)
            .frame(width: 60)
    }
}
