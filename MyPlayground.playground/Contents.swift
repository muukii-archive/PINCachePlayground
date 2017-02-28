//: Playground - noun: a place where people can play

import UIKit

import PINCache

public class DataCache {

  private let store: PINCache

  public init(name: String, rootPath: String? = nil) {
    if let rootPath = rootPath {
      self.store = PINCache(name: name, rootPath: rootPath)
    } else {
      self.store = PINCache(name: name)
    }
  }

  public func save(_ data: Data, forKey: String, completion: @escaping (_ key: String, _ data: Data) -> Void = { _ in }) {

    store.setObject(data as NSData, forKey: forKey) { (cache, key, object) in
      completion(key, data)
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
}

let store = DataCache(name: "me")

let responseJSON = "{}"
let data = responseJSON.data(using: .utf8)!

store.save(data, forKey: "me") { (key, data) in
  print(key, data)
}

print(store.data(forKey: "me"))
