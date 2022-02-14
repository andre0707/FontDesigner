//
//  FontDesigner.swift
//  
//
//  Created by Andre Albach on 14.02.22.
//

import Combine
import SwiftUI

/// The view model for `FontDesignerView`.
final class FontDesigner: ObservableObject {
    
    /// The font color
    @Published var fontColor: CGColor = UIColor.label.cgColor
    /// The font size
    @Published var fontSize: CGFloat = 16
    /// The font descriptor, if available
    @Published var fontDescriptor: UIFontDescriptor? = nil
    
    
    // MARK: - UI controling
    
    /// The font name string, displayed by the font picker
    @Published private(set) var displayedFontName: String = NSLocalizedString("Font", comment: "")
    /// The preview text to preview how the font configuration looks like
    @Published private(set) var previewText: AttributedString = AttributedString("Some preview text")
    
    /// Indicator, if the font picker is currently visible
    @Published var isFontPickerActive: Bool = false
    
    
    // MARK: - Other
    
    /// A store for all the subscriptions. So we can react on the changes
    private var subscriptions: Set<AnyCancellable> = []
    
    /// Initialisation
    init() {
        $fontDescriptor
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] newValue in
                self?.updatePreviewText()
                guard let fontName = newValue?.postscriptName else { return }
                
                self?.displayedFontName = String(format: NSLocalizedString("Font: #NAME#", comment: ""), fontName)
            }
            .store(in: &subscriptions)
        
        $fontSize
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updatePreviewText()
            }
            .store(in: &subscriptions)
    }
    
    /// This function will update the preview text and use the latest values
    private func updatePreviewText() {
        var text = AttributedString("Some preview text")
        if let fontDescriptor = fontDescriptor {
            text.uiKit.font = UIFont(descriptor: fontDescriptor, size: fontSize)
            
        } else {
            text.uiKit.font = UIFont.systemFont(ofSize: fontSize)
        }
        previewText = text
    }
}


// MARK: - Preview data

extension FontDesigner {
    /// Some preview data
    static let preview: FontDesigner = {
        let designer = FontDesigner()
        designer.fontSize = 25
        designer.fontColor = UIColor.red.cgColor
        designer.fontDescriptor = UIFontDescriptor(name: "Marker Felt", size: 25)
        
        return designer
    }()
}
