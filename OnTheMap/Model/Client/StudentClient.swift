//
//  StudentClient.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-23.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

class StudentClient {
    
    struct Auth {
        static var sessionId: String =  ""
        static var key: String = ""
    }
    
    /**
     
     List the endpoints accessible by the Student
     
     */
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getStudentsLocation
        case login
        
        var stringVaue: String {
            switch self {
            case .getStudentsLocation:
                return "\(Endpoints.base)/StudentLocation?order=-updatedAt&limit=100"
            case .login:
                return "\(Endpoints.base)/session"
            }
        }
        
        var url: URL {
            return URL(string: stringVaue)!
        }
    }
    
    class func getStudentList(completion: @escaping (StudentInformationResponse?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentsLocation.url, ResponseType: StudentInformationResponse.self) { (response, error) in
            if let response = response {
                completion(response, nil)
            }
            
            if let error = error {
                completion(nil, error)
            }
            
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let userInfo = Udacity(username: username, password: password)
        let loginInfo = LoginRequest(udacity: userInfo)
        
//        print(loginInfo)
        
        taskForPOSTRequest(url: Endpoints.login.url, body: loginInfo, reponseType: LoginResponse.self) { (response, error) in
            if let response = response {
                Auth.key = response.account.key
                Auth.sessionId = response.session.id
                completion(true, nil)
            }
            
            if let error = error {
                completion(false, error)
            }
        }
    }
    
    
    private class func taskForGETRequest<ResponseType: Decodable>(url: URL, ResponseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    private class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body: RequestType, reponseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let encoder = JSONEncoder()
        do {
            let body = try encoder.encode(body)
            request.httpBody = body
        } catch {
            DispatchQueue.main.async {
                completion(nil, error)
            }
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newData = data.subdata(in: 5..<data.count)
                let objectResponse = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(objectResponse, nil)
                }
            } catch {
                do {
                    let newData = data.subdata(in: 5..<data.count)
                    let errorObject = try decoder.decode(ErrorResponse.self, from: newData)
                    DispatchQueue.main.async {
                        completion(nil, errorObject)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        task.resume()
    }
    
}
