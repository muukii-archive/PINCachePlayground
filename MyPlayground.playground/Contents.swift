//: Playground - noun: a place where people can play

import UIKit

import PINCache

public class DataCache {

  private let store: PINCache

  public init(name: String, rootPath: String? = nil) {
    if let rootPath = rootPath {
      self.store = PINCache(name: name, rootPath: rootPath, fileExtension: nil)
    } else {
      self.store = PINCache(name: name)
    }
  }

  public func save(_ data: Data, forKey: String, completion: @escaping (_ key: String, _ data: Data) -> Void = { _ in }) {

    store.setObjectAsync(data as NSData, forKey: forKey) { (_, key, data) in
      completion(key, data as! Data)
    }
  }

  public func data(forKey: String) -> Data? {

    guard let object = store.object(forKey: forKey) else {
      return nil
    }
    guard let data = object as? Data else {
      assertionFailure()
      return nil
    }
    return data
  }

  public func purge() {
    store.removeAllObjects()
  }
}

let store = DataCache(name: "me")
store.purge()

let responseJSON = "{}"
let data = responseJSON.data(using: .utf8)!

store.save(data, forKey: "me") { (key, data) in
  print(key, data)
  print(store.data(forKey: "me"))
}

print(store.data(forKey: "me"))
