import Foundation

final class Closure {
    let regEnc = termMtd.secondMtd(usingKey: Dimensions.startKey)
    
    func run() {
        do {
            let result = try obsMng.act(message: regEnc,
                                          type: .one)
            print(result)
        } catch {
            print("Launch error")
        }

    }
}
