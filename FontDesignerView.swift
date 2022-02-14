//
//  FontDesignerView.swift
//  
//
//  Created by Andre Albach on 14.02.22.
//

import SwiftUI

/// A small view to pick a UIFont, set a font color and a font size.
/// There is also a preview included
struct FontDesignerView: View {
    
    /// The view model
    @ObservedObject var fontDesigner: FontDesigner
    
    /// The minimum font size the stepper allows
    let minimumFontSize: CGFloat = 8
    /// The maximum font size the stepper allows
    let maximumFontSize: CGFloat = 100
  
    /// The body of the view
    var body: some View {
        NavigationView {
            Form {
                Section("Preview") {
                    Text(fontDesigner.previewText)
                        .foregroundColor(Color(fontDesigner.fontColor))
                }
                
                Section("Configuration") {
                    NavigationLink(fontDesigner.displayedFontName, isActive: $fontDesigner.isFontPickerActive) {
                        UIFontPickerRepresentable(fontDesigner: fontDesigner)
                    }
                    
                    ColorPicker("Font color", selection: $fontDesigner.fontColor)
                    
                    Stepper("Font size (\(Float(fontDesigner.fontSize).formatted(.number.precision(.fractionLength(0)))))", value: $fontDesigner.fontSize, in: minimumFontSize ... maximumFontSize)
                }
            }
        }
    }
}


// MARK: - Previews

struct FontDesignerView_Previews: PreviewProvider {
    static var previews: some View {
        FontDesignerView(fontDesigner: FontDesigner.preview)
    }
}
