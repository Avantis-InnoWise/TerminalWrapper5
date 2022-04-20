import Foundation

/* Encryption/decryption */
final class TermMtd {
    /* Encrypting the string we pass as an argument. */
    /* The salt is this value - "SomeSalt123456dgsdgqg" and has the type utf8. */
    /* !! We have to use the same salt and separator to encrypt and decrypt !! */
    
    func firstMtd(usingKey key: String) -> String {
        let orig = [UInt8](key.utf8) // Original text in utf8.
        /* Сreate string from array of numbers with separator */
        return finarrState(from: orig,
                           key: key,
                           state: .start)
            .map { String($0) }
            .joined(separator: Dimensions.sprt)
    }
    // Decoding the string we pass as an argument
    func secondMtd(usingKey key: String) -> String {
        let orig = [UInt8](Dimensions.slt.utf8) // Salt in utf8.
        /* Сreate string from array */
        let arr = finarrState(from: orig,
                                            key: key,
                                            state: .end)
        guard let extStr = String(bytes: arr,
                                      encoding: .utf8)
        else { return "" }
        return extStr
    }
    
    func finarrState(from orig: [UInt8],
                            key: String,
                            state: TrfState) -> [UInt8]
    {
        let sltxt = [UInt8](Dimensions.slt.utf8) // original text in utf8
        var finarr = [UInt8]() // salt in utf8
        
        /* Choose encryption/decripton. */
        switch state {
        case .start:
            orig.enumerated().forEach { key in
                /* Сombine salt and the original string. */
                let item = mapKey(keyElement: key.element,
                                  keyOffset: key.offset,
                                  text: sltxt)
                finarr.append(item)
            }
        case .end:
            key.components(separatedBy: Dimensions.sprt)
                .map({ UInt8($0) ?? .zero })
                .enumerated()
                .forEach { key in
                    /* Сombine salt and the original string. */
                    let item = mapKey(keyElement: key.element,
                                      keyOffset: key.offset,
                                      text: sltxt)
                    finarr.append(item)
                }
        }
        
        return finarr
    }
    
    /* Function to map salt and any string. */
    private func mapKey(keyElement: UInt8,
                        keyOffset: Int,
                        text: [UInt8]) -> UInt8
    {
        return keyElement ^ text[keyOffset % text.count]
    }
}
