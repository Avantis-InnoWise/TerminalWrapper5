import Foundation

/* Encryption/decryption */
class TerminalCommand {
    /* Encrypting the string we pass as an argument. */
    /* The salt is this value - "SomeSalt123456dgsdgqg" and has the type utf8. */
    /* !! We have to use the same salt and separator to encrypt and decrypt !! */
    
    func startTransformation(usingKey key: String) -> String {
        let original = [UInt8](key.utf8) // Original text in utf8.
        /* Сreate string from array of numbers with separator */
        return finalArrayForState(from: original,
                                  key: key,
                                  state: .start)
            .map { String($0) }
            .joined(separator: Dimensions.separator)
    }
    // Decoding the string we pass as an argument
    func endTransformation(usingKey key: String) -> String {
        let original = [UInt8](Dimensions.salt.utf8) // Salt in utf8.
        /* Сreate string from array */
        let finalArray = finalArrayForState(from: original,
                                            key: key,
                                            state: .end)
        guard let exitString = String(bytes: finalArray,
                                      encoding: .utf8)
        else { return "" }
        return exitString
    }
    
    func finalArrayForState(from original: [UInt8],
                            key: String,
                            state: TransformationState) -> [UInt8]
    {
        let startText = [UInt8](Dimensions.salt.utf8) // original text in utf8
        var finalArray = [UInt8]() // salt in utf8
        
        /* Choose encryption/decripton. */
        switch state {
        case .start:
            original.enumerated().forEach { key in
                /* Сombine salt and the original string. */
                let item = mapKey(keyElement: key.element,
                                  keyOffset: key.offset,
                                  startText: startText)
                finalArray.append(item)
            }
        case .end:
            key.components(separatedBy: Dimensions.separator)
                .map({ UInt8($0) ?? .zero })
                .enumerated()
                .forEach { key in
                    /* Сombine salt and the original string. */
                    let item = mapKey(keyElement: key.element,
                                      keyOffset: key.offset,
                                      startText: startText)
                    finalArray.append(item)
                }
        }
        
        return finalArray
    }
    
    private func mapKey(keyElement: UInt8,
                        keyOffset: Int,
                        startText: [UInt8]) -> UInt8
    {
        return keyElement ^ startText[keyOffset % startText.count]
    }
}
