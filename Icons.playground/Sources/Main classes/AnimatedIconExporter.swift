import UIKit

public enum AnimatedIconExporterDirection {
    case Forward
    case Backward
    case ForwardAndBack
}

public class AnimatedIconExporter {

    var icon: AnimatedIcon
    var direction: AnimatedIconExporterDirection
    var count: Int
    var frames: [UIImage]
    var folder: URL

    // MARK: - Initialization

    public init(icon: AnimatedIcon, folder: URL, direction: AnimatedIconExporterDirection = .Forward, count: Int = 50) {
        self.icon = icon
        self.direction = direction
        self.count = count
        self.folder = folder
        self.frames = []
    }

    // MARK: - Exporting & saving

    public func export() -> [UIImage] {
        frames = []
        for i in 0...count {
            if let image = icon.image(at: position(at: i)) {
                frames.append(image)
            }
        }
        return frames
    }

    public func save() {

        let name = NSStringFromClass(icon.dynamicType).components(separatedBy: ".").last

        if !FileManager.default().fileExists(atPath: folder.path!) {
            try! FileManager.default().createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd_HH-mm-ss"
        let date = formatter.string(from: Date())

        let images = export()
        for i in 0...(images.count - 1) {

            let fileName = String(format: "%@_%@_%03d.png", arguments: [date, name!, i])
            let filePath = try! folder.appendingPathComponent(fileName)
            let data = UIImagePNGRepresentation(images[i])

            try! data?.write(to: filePath)

        }
    }

    // MARK: - Helper functions

    func position(at index: Int) -> CGFloat {
        var value = CGFloat(index) / CGFloat(count)

        // Calculate position of animation on timeline
        if direction == .Backward {
            value = 1 - value
        } else if direction == .ForwardAndBack {
            value = value.truncatingRemainder(dividingBy: 0.5) * 2 * (value.truncatingRemainder(dividingBy: 1) >= 0.5 ? -1 : 1) + (value.truncatingRemainder(dividingBy: 1) >= 0.5 ? 1 : 0)
        }

        // Apply animation function
        switch icon.timingFunction {
        case kCAMediaTimingFunctionEaseInEaseOut:
            value = AnimationFunctions.sinEaseInOut(x: value)
        case kCAMediaTimingFunctionEaseIn:
            value = AnimationFunctions.sinEaseOut(x: value)
        case kCAMediaTimingFunctionEaseOut:
            value = AnimationFunctions.sinEaseIn(x: value)
        default:
            value = AnimationFunctions.linear(x: value)
        }

        return value
    }

}
