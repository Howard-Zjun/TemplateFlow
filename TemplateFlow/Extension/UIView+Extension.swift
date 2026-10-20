import UIKit

extension UIView {
    
    var width: CGFloat {
        CGRectGetWidth(frame)
    }
    
    var height: CGFloat {
        CGRectGetHeight(frame)
    }
    
    var minX: CGFloat {
        CGRectGetMinX(frame)
    }
    
    var minY: CGFloat {
        CGRectGetMinY(frame)
    }
    
    var maxX: CGFloat {
        CGRectGetMaxX(frame)
    }
    
    var maxY: CGFloat {
        CGRectGetMaxY(frame)
    }
}
