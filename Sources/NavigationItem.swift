//
//  Navigation.swift
//  JSONSchema
//
//  Created by Tal Zion on 22/03/2017.
//  Copyright © 2017 Cocode. All rights reserved.
//

import Foundation

public enum NavigationError: Error {
  case error(String)
}

/*
 NavigationIten represents a navigation junction within a stack
 */
public class NavigationItem {
  
  public let type:NavigationType!
  public var index:Int?
  public var key:String
  public var successor:NavigationItem?
  public var action:NavigationAction?
  
  public init(dictionary:[AnyHashable:Any]) throws {
    
    if let stringAction = dictionary["action"] as? String,
      let action = NavigationAction(rawValue: stringAction) {
      self.action = action
    }
    
    if let stringType = dictionary["type"] as? String,
      let type = NavigationType(rawValue: stringType) {
      self.type = type
    } else {
      throw NavigationError.error("Navigation Type does not exists")
    }
    
    self.index = dictionary["index"] as? Int
    self.key = dictionary["key"] as? String ?? ""
    
    if let successorDictionary = dictionary["successor"] as? [AnyHashable:Any] {
      do {
        self.successor = try NavigationItem(dictionary: successorDictionary)
      } catch NavigationError.error(let m) {
        throw NavigationError.error(m)
      }
    }
  }
}
