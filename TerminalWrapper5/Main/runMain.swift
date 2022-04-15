import Foundation

struct RunMain {
    let startEncription = termCommnd.endTransformation(usingKey: Dimensions.startKey)
    
    func run() {
        do {
            let result = try manager.start(startEncription, type: .first)
            print(result)
        } catch {
            print("Launch error")
        }

    }
}
