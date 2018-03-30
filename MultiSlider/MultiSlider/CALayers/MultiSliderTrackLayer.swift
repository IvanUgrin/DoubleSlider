//
//  MultiSliderTrackLayer.swift
//  MultiSlider
//
//  Created by josh on 2018/03/30.
//  Copyright © 2018年 yhkaplan. All rights reserved.
//

import QuartzCore

// MultiSliderTrackLayer represents the colorized space between
// the two thumb layers
// I decided not to make this class open because it is very small,
// meaning that developers could make their own custom CALayer
// subclass in the same amount of time as it would take to subclass
// this one
public class MultiSliderTrackLayer: CALayer, MultiSliderLayer {
    weak var multiSlider: MultiSlider?
    
    override public func draw(in ctx: CGContext) {
        guard let slider = multiSlider else { return }
        
        // Clip
        let cornerRadius = bounds.height * slider.roundedness / 2.0
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        
        // Fill track
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        
        // Fill highlighted range
        ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
        let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
        let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
        let rect = CGRect(x: lowerValuePosition,
                          y: 0.0,
                          width: upperValuePosition - lowerValuePosition,
                          height: bounds.height)
        ctx.fill(rect)
    }
}
