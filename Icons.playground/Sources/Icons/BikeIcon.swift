//
//  BikeIcon.swift
//  MKJIcons
//
//  Created by Matěj Jirásek on 27/04/16.
//  Copyright © 2016 Matěj Kašpar Jirásek. All rights reserved.
//

import UIKit

@IBDesignable
public class BikeIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var strokeColor: UIColor = UIColor.iconOrangeColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var visible: Bool {
        get {
            return Bool(value)
        }
        set (newValue) {
            value = CGFloat(newValue)
        }
    }

    // MARK: - Drawing methods

    override func draw(in context: CGContext, at time: CGFloat) {

        if time == 0 {
            return
        }

        // General Declarations

        context.clear(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        context.scale(x: scale, y: scale)

        strokeColor.setStroke()

        // Variable Declarations
        let firstDraw: CGFloat = time * 3
        let one: CGFloat = firstDraw < 0 ? 0 : (firstDraw > 1 ? 1 : firstDraw)
        let secondDraw: CGFloat = time * 3 - 1
        let two: CGFloat = secondDraw < 0 ? 0 : (secondDraw > 1 ? 1 : secondDraw)
        let thirdDraw: CGFloat = time * 3 - 2
        let three: CGFloat = thirdDraw < 0 ? 0 : (thirdDraw > 1 ? 1 : thirdDraw)

        let frameLine: CGFloat = two * 88
        let bikeLine: CGFloat = one * 69
        let barLine: CGFloat = three * 33
        let seatLine: CGFloat = three * 38

        // First wheel
        context.saveGState()
        context.translate(x: 29.5, y: 64.5)
        context.rotate(byAngle: 110 * CGFloat.pi / 180)

        let firstWheel = UIBezierPath(style: self)
        firstWheel.move(to: CGPoint(x: -11, y: 0))
        firstWheel.addCurve(to: CGPoint(x: 0, y: 11), controlPoint1: CGPoint(x: -11, y: 6.08), controlPoint2: CGPoint(x: -6.08, y: 11))
        firstWheel.addCurve(to: CGPoint(x: 11, y: 0), controlPoint1: CGPoint(x: 6.08, y: 11), controlPoint2: CGPoint(x: 11, y: 6.08))
        firstWheel.addCurve(to: CGPoint(x: 0, y: -11), controlPoint1: CGPoint(x: 11, y: -6.08), controlPoint2: CGPoint(x: 6.08, y: -11))
        firstWheel.addCurve(to: CGPoint(x: -11, y: 0), controlPoint1: CGPoint(x: -6.08, y: -11), controlPoint2: CGPoint(x: -11, y: -6.08))
        firstWheel.close()

        context.saveGState()
        context.setLineDash(phase: 0, lengths: [bikeLine, 100], count: 2)
        firstWheel.stroke()
        context.restoreGState()

        context.restoreGState()


        // Second wheel
        context.saveGState()
        context.translate(x: 70.5, y: 64.5)
        context.scale(x: -1, y: 1)
        context.rotate(byAngle: -110 * CGFloat.pi / 180)

        let secondWheel = UIBezierPath(style: self)
        secondWheel.move(to: CGPoint(x: 11, y: 0))
        secondWheel.addCurve(to: CGPoint(x: 0, y: 11), controlPoint1: CGPoint(x: 11, y: 6.08), controlPoint2: CGPoint(x: 6.08, y: 11))
        secondWheel.addCurve(to: CGPoint(x: -11, y: 0), controlPoint1: CGPoint(x: -6.08, y: 11), controlPoint2: CGPoint(x: -11, y: 6.08))
        secondWheel.addCurve(to: CGPoint(x: 0, y: -11), controlPoint1: CGPoint(x: -11, y: -6.08), controlPoint2: CGPoint(x: -6.08, y: -11))
        secondWheel.addCurve(to: CGPoint(x: 11, y: 0), controlPoint1: CGPoint(x: 6.08, y: -11), controlPoint2: CGPoint(x: 11, y: -6.08))
        secondWheel.close()

        context.saveGState()
        context.setLineDash(phase: 0, lengths: [bikeLine, 100], count: 2)
        secondWheel.stroke()
        context.restoreGState()

        context.restoreGState()

        // Frame
        if two > 0 {
            let framePath = UIBezierPath(style: self)
            framePath.move(to: CGPoint(x: 61.5, y: 46.5))
            framePath.addLine(to: CGPoint(x: 37.5, y: 46.5))
            framePath.addLine(to: CGPoint(x: 53.5, y: 65.5))
            framePath.addLine(to: CGPoint(x: 70.5, y: 65.5))
            framePath.addLine(to: CGPoint(x: 61.5, y: 46.5))
            framePath.close()

            context.saveGState()
            context.setLineDash(phase: 0, lengths: [frameLine, 400], count: 2)
            framePath.stroke()
            context.restoreGState()
        }

        // Seat and bars
        if three > 0 {
            let bars = UIBezierPath(style: self)
            bars.move(to: CGPoint(x: 30.5, y: 63.5))
            bars.addLine(to: CGPoint(x: 39.5, y: 41.5))
            bars.addLine(to: CGPoint(x: 30.5, y: 41.5))

            context.saveGState()
            context.setLineDash(phase: 0, lengths: [barLine, 100], count: 2)
            bars.stroke()
            context.restoreGState()

            let seat = UIBezierPath(style: self)
            seat.move(to: CGPoint(x: 53.5, y: 65.5))
            seat.addLine(to: CGPoint(x: 64.5, y: 38.5))
            seat.addLine(to: CGPoint(x: 56.5, y: 38.5))

            context.saveGState()
            context.setLineDash(phase: 0, lengths: [seatLine, 100], count: 2)
            seat.stroke()
            context.restoreGState()
        }

    }

}
