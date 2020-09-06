//
//  InformationNetworking.swift
//  Angkasa Pura Solusi
//
//  Created by Arief Zainuri on 01/08/19.
//  Copyright © 2019 Gama Techno. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking: BaseNetworking {
    
    func login(request: AuthRequest, completion: @escaping(_ error: String?, _ loginModel: AuthModel?, _ isExpired: Bool?) -> Void) {
        let url = "\(baseUrl())auth/login"
        alamofirePostJSONRequest(url: url, body: request.asDictionary, completion: completion)
    }
    
    func register(request: AgentRegisterRequest, completion: @escaping(_ error: String?, _ agentRegister: AgentRegisterModel?, _ isExpired: Bool) -> Void) {
        let url = "\(baseUrl())"
    }
    
    func cluster(completion: @escaping(_ error: String?, _ cluster: ClusterModel?, _ isExpired: Bool?) -> Void) {
        let url = "\(baseUrl())api/ticket/cluster"
        alamofireGet(url: url, body: nil, completion: completion)
    }
}
