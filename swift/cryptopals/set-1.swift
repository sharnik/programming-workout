import Foundation

extension Data {

  // Exercise #1
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

  // Exercise #1
  func base64String() -> String {
    return self.base64EncodedString()
  }

  func hexString() -> String {
    return map{ String(format: "%02hhx", $0) }.joined()
  }

  func printableString() -> String {
    return String(data: self, encoding: String.Encoding.utf8)!
  }

  // Exercise #2
  func xor(otherData: Data) -> Data {
    var result = Data(capacity: self.count)
    for (index, element) in self.enumerated() {
      let xoredValue = element ^ (otherData[index] as UInt8)
      result.append(xoredValue)
    }
    return result
  }
}

// Exercise #1
// let bytes = Data(hexString: "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")!
// print(bytes.base64String())
// print(bytes.printableString())

// Exercise #2
// let hexOne = Data(hexString: "1c0111001f010100061a024b53535009181c")!
// let hexTwo = Data(hexString: "686974207468652062756c6c277320657965")!
// let resultHex = hexOne.xor(otherData: hexTwo)
// print(resultHex.hexString())
// print(resultHex.printableString())
