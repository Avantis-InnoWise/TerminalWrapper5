import Foundation

let termCommnd = TerminalCommand()
let manager = Manager()
let startEncription = termCommnd.endTransformation(usingKey: Dimensions.startKey)

do {
    let result = try manager.start(startEncription, type: .first)
    print(result)
} catch {
    print("Launch error")
}
