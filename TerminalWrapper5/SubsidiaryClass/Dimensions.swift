import Foundation

class Dimensions {
    static let first = "124FGG13FGG4FGG11FGG124FGG3FGG13FGG7FGG89" // bash
    static let second = "124FGG13FGG4FGG11FGG124FGG27FGG31FGG28" // shell
    static let sprt = "FGG" // Is a separator. We use it to create string from array of numbers (UTF8), and separate encrypted string to original.
    static let slt = "SomeSalt123456dgsdgqg" // Is a salt. We use it to mix with our original string.
    static let encKey = "126FGG12" // key for encryption
    static let startKey = "63FGG28" // application start key
}
