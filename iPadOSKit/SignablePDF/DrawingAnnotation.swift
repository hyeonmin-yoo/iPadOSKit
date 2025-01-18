//
//  Untitled.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 12/01/2025.
//

import Foundation
import PDFKit
import PencilKit

class DrawingAnnotation: PDFAnnotation {
    var canvas: PKCanvasView
    
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        let image = canvas.drawing.image(from: canvas.bounds, scale: 3.0)
        UIGraphicsPushContext(context)
        context.saveGState()
        context.translateBy(x: .zero, y: bounds.height)
        context.scaleBy(x: 1.0, y: -1.0)
        image.draw(in: bounds)
        context.restoreGState()
        UIGraphicsPopContext()
    }
    
    init(from canvas: PKCanvasView) {
        self.canvas = canvas
        super.init(bounds: canvas.bounds, forType: .stamp, withProperties: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
