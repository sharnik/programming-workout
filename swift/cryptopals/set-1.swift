import Foundation

// Exercise #1
extension Data {
  
  public init?(hexString: String) {
    var characters = hexString.characters
    self.init(capacity: characters.count / 2)

    while characters.count > 0 {
      let hexCode = String(characters.prefix(2))
      characters = characters.dropFirst(2)

      guard let byteValue = UInt8(hexCode, radix: 16) else {
        print("Error parsing character \(hexCode) in string \(self). Aborting.")
        return nil
      }
      self.append(byteValue)
    }
  }

  func base64String() -> String {
    return self.base64EncodedString()
  }

  func printableString() -> String {
    return String(data: self, encoding: String.Encoding.utf8)!
  }
}

let bytes = Data(hexString: "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")!
print(bytes.base64String())
print(bytes.printableString())

