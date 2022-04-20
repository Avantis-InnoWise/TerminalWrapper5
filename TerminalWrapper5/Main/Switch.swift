import Foundation

/* Types of commands. */
enum Switch {
    case one
    case two
    
    var rawValue: String {
        switch self {
        case .one:
            return termMtd.secondMtd(
                usingKey: Dimensions.first
            )
        case .two:
            return termMtd.secondMtd(
                usingKey: Dimensions.second
            )
        }
    }
}
