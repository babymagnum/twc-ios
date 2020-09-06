//
//  Request.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/09/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation

/// Auth
struct AuthRequest {
    var email: String
    var password: String
    
    var asDictionary : [String: Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}

/// Agen Update
struct AgentUpdateRequest {
    var agent: String
    var address: String
    var group: Int
    var contact: AgentUpdateContact
    
    var asDictionary : [String: Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}

struct AgentUpdateContact {
    var telp: String
    var no_id: String
    var email: String
    var pic_name: String
    var agent_address_detail: String
    var npwp: String
}

/// Register
struct AgentRegisterRequest {
    var nama_depan: String
    var email: String
    var password: String
    var nationality_id: Int
    var agent_id: Int
    var type: String
    
    var asDictionary : [String: Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}

/// Password Forgot
struct PasswordForgotRequest {
    var email: String
    
    var asDictionary : [String: Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}

/// Password Forgot Update
struct PasswordForgotUpdateRequest {
    var email: String
    var token: String
    var password: String
    var confirm_password: String
    
    var asDictionary : [String: Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}


