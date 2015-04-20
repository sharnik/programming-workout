//: Playground - noun: a place where people can play

import Cocoa

class MyView : NSView {
    override func drawRect(rect: NSRect) {

        let bezierPath = NSBezierPath()
        let squareRect = CGRectInset(rect, rect.size.width * 0.45, rect.size.height * 0.05)
        let circleRect = CGRectInset(rect, rect.size.width * 0.3, rect.size.height * 0.3)
        let cornerRadius : CGFloat = 20
        
        var circlePath = NSBezierPath(ovalInRect: circleRect)
        var squarePath = NSBezierPath(roundedRect: squareRect, xRadius: cornerRadius, yRadius: cornerRadius)
        squarePath.appendBezierPath(circlePath)
        bezierPath.appendBezierPath(squarePath)
        
        NSGraphicsContext.saveGraphicsState()

        let shadow = NSShadow()
        shadow.shadowColor = NSColor.blackColor()
        shadow.shadowOffset = NSSize(width: 3, height: -3)
        shadow.shadowBlurRadius = 10
        shadow.set()

        let startColor = NSColor.redColor()
        let endColor = NSColor.orangeColor()
        let gradient = NSGradient(startingColor: startColor, endingColor: endColor)

        var context = NSGraphicsContext.currentContext()?.CGContext
        var rotationTransform = CGAffineTransformMakeRotation(CGFloat(M_PI) / 4.0)
        CGContextConcatCTM(context, rotationTransform)
        
        gradient.drawInBezierPath(bezierPath, angle: 90)
        
        
        
        NSGraphicsContext.restoreGraphicsState()
    }
}

let viewRect = NSRect(x: 0, y: 0, width: 100, height: 100)
let myEmptyView = MyView(frame: viewRect)
