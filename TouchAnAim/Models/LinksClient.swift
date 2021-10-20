//
//  LinksClient.swift
//  TouchAnAim
//
//  Created by Petro on 20.10.2021.
//

import Foundation

class LinksClient {
    let session: URLSession
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getLinks (requestBaseURL: String, completion: @escaping (Result<LinkResponse, Error>) -> Void) {
        
        let urlComponents = URLComponents(string: requestBaseURL)!
        
        let request = URLRequest(url: urlComponents.url!)
        
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                print("data=\(String(data: data, encoding: .utf8)!)")
                let response = try self.jsonDecoder.decode(LinkResponse.self, from: data)
                completion(.success(response))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
