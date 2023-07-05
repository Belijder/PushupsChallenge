//
//  ChartAnnotationLayoutProtocol.swift
//  PushupsChallenge
//
//  Created by Jakub Zajda on 05/07/2023.
//

import Foundation
import Charts

protocol ChartAnnotationLayoutProtocol: AnyObject {
    func calculateAnnotationPosition(annotationWidth: CGFloat, xPosition: CGFloat, chartWidth: CGFloat) -> AnnotationPosition
    func calculateAnnotationOffset(annotationWidth: CGFloat, xPosition: CGFloat, chartWidth: CGFloat) -> CGFloat
}

extension ChartAnnotationLayoutProtocol {
    func calculateAnnotationPosition(annotationWidth: CGFloat, xPosition: CGFloat, chartWidth: CGFloat) -> AnnotationPosition {
        var annotationPosition: AnnotationPosition
        
        if xPosition < annotationWidth {
            annotationPosition = .topTrailing
        } else if xPosition > (chartWidth - annotationWidth - 30) {
            annotationPosition = .topLeading
        } else {
            annotationPosition = .top
        }
        
        return annotationPosition
    }
    
    
    func calculateAnnotationOffset(annotationWidth: CGFloat, xPosition: CGFloat, chartWidth: CGFloat) -> CGFloat {
        var offset: CGFloat
        
        if xPosition < annotationWidth {
            offset = -((xPosition / 2) + 10)
        } else if xPosition > (chartWidth - annotationWidth - 30) {
            
            let o = (chartWidth - xPosition - 30) / 2
            offset = o + 10
        } else {
            offset = 0
        }
        
        return offset
    }
}

