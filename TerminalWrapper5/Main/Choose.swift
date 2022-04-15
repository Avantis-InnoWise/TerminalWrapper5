import Foundation

/* Types of commands. */
enum Choose {
    case first
    case second
    
    var rawValue: String {
        switch self {
        case .first:
            return termCommnd.endTransformation(
                usingKey: Dimensions.firstCommand
            )
        case .second:
            return termCommnd.endTransformation(
                usingKey: Dimensions.secondCommand
            )
        }
    }
}
