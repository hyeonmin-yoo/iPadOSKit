//
//  OverlayProvider.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 12/01/2025.
//

import PDFKit
import PencilKit

final class OverlayProvider: NSObject, PDFPageOverlayViewProvider {
    private var pageToViewMapping = [PDFPage: PKCanvasView]()
    private var type: PKTool = Tool.pen.value

    func pdfView(_ view: PDFView, overlayViewFor page: PDFPage) -> UIView? {
        if let mappedCanvasView = pageToViewMapping[page] {
            return mappedCanvasView
        } else {
            let canvasView = PKCanvasView(frame: .zero)
            canvasView.drawingPolicy = .pencilOnly
            canvasView.tool = Tool.pen.value
            canvasView.backgroundColor = .clear
            pageToViewMapping[page] = canvasView
            return canvasView
        }
    }
    
    func save() {
        for (page, canvas) in pageToViewMapping {
            let newAnnotation = DrawingAnnotation(from: canvas)
            page.addAnnotation(newAnnotation)
        }
    }
    
    func deleteAll() {
        for (_, canvas) in pageToViewMapping {
            canvas.drawing.strokes = []
        }
    }
    
    func tool(_ type: Tool) {
        for (_, canvas) in pageToViewMapping {
            canvas.tool = type.value
        }
    }
    
    func isEmpty() -> Bool {
        var isEmptyStroke = true
        for (_, canvas) in pageToViewMapping where canvas.drawing.strokes.count != 0 {
            isEmptyStroke = false
        }
        return isEmptyStroke
    }
}

extension OverlayProvider {
    enum Tool {
        case pen
        case eraser
        
        var value: PKTool {
            switch self {
            case .pen: PKInkingTool(.pen, color: .black, width: 1)
            case .eraser: PKEraserTool(.bitmap)
            }
        }
    }
}
