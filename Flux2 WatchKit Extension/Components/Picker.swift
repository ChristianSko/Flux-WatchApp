//
//  PickerF.swift
//  Flux2 WatchKit Extension
//
//  Created by Christian Skorobogatow on 12/6/21.
//

import SwiftUI

struct PickerF: View {
    
    let label: String
    var unit: [Int]

    @Binding var selected: Int
    
    var body: some View {
        VStack {
            HStack {
                Picker(label, selection: $selected) {
                    ForEach(unit, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
        }
    }
}

//struct PickerF_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerF(label: "", unit: [1,2,3,4,5], selected: 1)
//    }
//}
