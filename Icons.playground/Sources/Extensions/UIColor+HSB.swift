import UIKit

public typealias UIColorHSBComponents = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

public extension UIColor {

    // MARK: - Getting HSB components

    var hue: CGFloat {
        return hsbComponents.hue
    }

    var saturation: CGFloat {
        return hsbComponents.saturation
    }

    var brightness: CGFloat {
        return hsbComponents.brightness
    }

    var hsbComponents: UIColorHSBComponents {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0

        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        return (hue, saturation, brightness, alpha)
    }

    // MARK: - Creating from HSB components

    func colorWithHue(_ hue: CGFloat) -> UIColor {
        return UIColor(hue: hue.truncatingRemainder(dividingBy: 1), saturation: saturation, brightness: brightness, alpha: alpha)
    }

    func colorWithBrightness(_ brightness: CGFloat) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    func colorWithSaturation(_ saturation: CGFloat) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

}
