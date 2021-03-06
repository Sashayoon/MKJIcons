import UIKit

@IBDesignable
public class AnimatedIcon: UIControl {

    // MARK: - Inspectable properties

    @IBInspectable public var animationDuration: Double = 0.4

    @IBInspectable public var lineWidth: CGFloat = 2.0 {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var fillAlpha: CGFloat = 0.5 {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var animationRepeat: Bool = false {
        didSet {

            if animationRepeat {
                animateTo(CGFloat(!Bool(value)))
            }

            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var animationAutoreverses: Bool = true {
        didSet {

            if animationRepeat {
                animateTo(CGFloat(!Bool(value)))
            }

            layer.setNeedsDisplay()
        }
    }



    // MARK: - Properties

    public var colorMode: UIColorMode = .HSB {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    public var lineCap: CGLineCap = .Round {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    public var lineJoin: CGLineJoin = .Round {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    public var timingFunction = kCAMediaTimingFunctionEaseInEaseOut

    public var value: CGFloat = 0 {
        didSet {

            if oldValue != value {
                animateTo(value)
            }

            if enabled {
                self.sendActionsForControlEvents(.ValueChanged)
            }

            layer.setNeedsDisplay()
        }
    }

    // MARK: - Internal properties

    var scale: CGFloat {
        return min(frame.size.width, frame.size.height) / 100
    }

    var scaledLineWidth: CGFloat {
        return lineWidth / scale
    }

    // MARK: - Initialization

    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()

        setContentsScale()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setContentsScale()
    }

    // MARK: - Internal helper methods

    func setContentsScale() {
        layer.setNeedsDisplay()

        let scale = UIScreen.mainScreen().scale
        layer.contentsScale = scale
        contentScaleFactor = scale
    }

    // MARK: - Drawing methods

    override public class func layerClass() -> AnyClass {
        return AnimationLayer.self
    }

    override public func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        if let layer = layer as? AnimationLayer {
            draw(layer.value)
        }
        UIGraphicsPopContext()
    }

    public func image(at: CGFloat = 0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, contentScaleFactor)
        draw(at)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /**
        Draws the content of the icons. Needs to be overriden in subclasses of `AnimatedIcon`.

        - Parameter time: The position of animation, start of the animation will be 0 and the end will be 1. If the animation is reverted the value will be changing from 1 to 0.
    */
    func draw(time: CGFloat = 0) {
        fatalError("Method must be overriden in subclasses. Do not instantiate this class directly.")
    }

    public func animateTo(goal: CGFloat) {

        if let layer = layer as? AnimationLayer {

            #if TARGET_INTERFACE_BUILDER

                layer.value = goal
                layer.setNeedsDisplay()

            #else

                layer.removeAllAnimations()

                let timing: CAMediaTimingFunction = CAMediaTimingFunction(name: timingFunction)
                let animation = CABasicAnimation(keyPath: "value")
                animation.duration = animationDuration
                animation.fillMode = kCAFillModeBoth
                animation.timingFunction = timing
                animation.fromValue = layer.value
                animation.toValue = goal

                if animationRepeat {
                    animation.repeatCount = Float.infinity
                    animation.autoreverses = animationAutoreverses
                }

                layer.addAnimation(animation, forKey: nil)

                CATransaction.begin()
                CATransaction.setDisableActions(true)
                layer.value = goal
                CATransaction.commit()

            #endif
        }
    }

    // MARK: - Interaction

    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        if enabled {
            value = (value == 0 ? 1 : 0)
        }
    }

}
