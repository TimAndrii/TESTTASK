//
//  PositionView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 28.05.2025.
//

import SwiftUI

struct PositionsView: View {
    @Binding var position: Positions
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select your position")
                .font(.NSMedium18)
                .padding(.leading, 16)
            
            ForEach(Positions.allCases, id: \.self) { posType in
                RadioButton(label: posType, isSelected: position == posType) {
                    position = posType
                }
                .animation(.bouncy, value: position)
            }
        }
        .padding(.top, 24)
    }
}
