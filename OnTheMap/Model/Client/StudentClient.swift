//
//  StudentClient.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-23.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

class StudentClient {
    
    /**
     
     List the endpoints accessible by the Student
     
     */
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getStudentsLocation
        
        var stringVaue: String {
            switch self {
            case .getStudentsLocation:
                return "\(Endpoints.base)/StudentLocation?order=-updatedAt"
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
    
}
