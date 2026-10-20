import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    convenience init(h: Int, s: Int, b: Int) {
        self.init(h: h, s: s, b: b, a: 1)
    }
    
    convenience init(h: Int, s: Int, b: Int, a: CGFloat) {
        self.init(hue: CGFloat(h) / 360.0, saturation: CGFloat(s) / 100.0, brightness: CGFloat(b) / 100.0, alpha: a)
    }
    
    convenience init(hexValue: Int) {
        self.init(hexValue: hexValue, a: 1)
    }
    
    convenience init(hexValue: Int, a: CGFloat) {
        self.init(r: (hexValue >> 16) & 0xff, g: (hexValue >> 8) & 0xff, b: hexValue & 0xff, a: a)
    }
}
