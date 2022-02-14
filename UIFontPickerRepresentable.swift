//
//  UIFontPickerRepresentable.swift
//  
//
//  Created by Andre Albach on 14.02.22.
//

import SwiftUI

/// A representable to display a `UIFont` picker
struct UIFontPickerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIFontPickerViewController
    
    /// Reference to the underlaying view model
    let fontDesigner: FontDesigner
    
    func makeUIViewController(context: Context) -> UIFontPickerViewController {
        let vc = UIFontPickerViewController()
        vc.delegate = context.coordinator
        vc.selectedFontDescriptor = fontDesigner.fontDescriptor
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIFontPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(fontDesigner: fontDesigner)
    }
    
    /// Coordinator class to get callbacks when a font is picked
    final class Coordinator: NSObject, UIFontPickerViewControllerDelegate {
        
        /// Reference to the underlaying view model
        private let fontDesigner: FontDesigner
        
        /// Initialisation
        /// - Parameter fontDesigner: The underlaying view model
        init(fontDesigner: FontDesigner) {
            self.fontDesigner = fontDesigner
        }
        
        func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
            fontDesigner.fontDescriptor = viewController.selectedFontDescriptor
            fontDesigner.isFontPickerActive = false
        }
    }
}


// MARK: - Preview

struct UIFontPickerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        UIFontPickerRepresentable(fontDesigner: FontDesigner.preview)
    }
}
