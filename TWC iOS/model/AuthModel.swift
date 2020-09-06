//
//  LoginModel.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/09/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation

/// LOGIN
struct AuthModel: Decodable {
    var code: String
    var data: AuthData?
    var message: String
    var success: Bool
}

struct AuthData: Decodable {
    var agent_id: Int?
    var email: String?
    var token: String?
}

/// FORGOT PASSWORD
struct PasswordForgotModel: Decodable {
    var code: String
    var data: PasswordForgotData?
    var message: String
    var success: Bool
}

struct PasswordForgotData: Decodable {
    var email: String?
}

/// REGISTER
struct AgentRegisterModel: Decodable {
    var code: String
    var data: AgentRegisterData?
    var message: String
    var success: Bool
}

struct AgentRegisterData: Decodable {
    var email: String?
    var name_depan: String?
    var type: String?
}
