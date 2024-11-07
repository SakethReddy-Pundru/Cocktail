//
//  SegmentControl.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

// MARK: - Segment Control

import SwiftUI

/// A custom view that displays a horizontal segmented control for selecting options.
struct SegmentControl: View {
    
    // MARK: Properties
    
    /// The array of options to be displayed in the segment control.
    let options: [String]
    
    /// A binding to the currently selected option.
    @Binding var selectedOption: String
    
    // MARK: Body
    
    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Text(option)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        selectedOption == option
                        ? Color(.systemGray5)
                        : Color.clear
                    )
                    .cornerRadius(15)
                    .onTapGesture {
                        selectedOption = option
                    }
                    .foregroundColor(selectedOption == option ? Color.primary : Color.secondary)
            }
        }
        .padding()
        .background(
            // Background with rounded rectangle and stroke
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}
