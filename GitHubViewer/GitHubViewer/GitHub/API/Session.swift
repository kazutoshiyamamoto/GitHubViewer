//
//  Session.swift
//  GitHubViewer
//
//  Created by home on 2021/02/26.
//

import Foundation

final class Session {
    private let additionalHeaderFields: () -> [String: String]?
    private let session: URLSession
    
    init(additionalHeaderFields: @escaping () -> [String: String]? = { nil }, session: URLSession = .shared) {
        self.additionalHeaderFields = additionalHeaderFields
        self.session = session
    }
    
    @discardableResult
    func send<T: Request>(_ request: T, completion: @escaping (Result<T.Response>) -> ()) -> URLSessionTask? {
        let url = request.baseURL.appendingPathComponent(request.path)

        guard var componets = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(SessionError.failedToCreateComponents(url)))
            return nil
        }
        componets.queryItems = request.queryParameters?.compactMap(URLQueryItem.init)
        
        guard var urlRequest = componets.url.map({ URLRequest(url: $0) }) else {
            completion(.failure(SessionError.failedToCreateURL(componets)))
            return nil
        }
        urlRequest.httpMethod = request.method.rawValue
        
        let headerFields: [String: String]
        if let additionalHeaderFields = additionalHeaderFields() {
            headerFields = request.headerFields.merging(additionalHeaderFields, uniquingKeysWith: +)
        } else {
            headerFields = request.headerFields
        }
        
        urlRequest.allHTTPHeaderFields = headerFields
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(SessionError.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(SessionError.noData(response)))
                return
            }
            
            guard  200..<300 ~= response.statusCode else {
                let message = try? JSONDecoder().decode(SessionError.Message.self, from: data)
                completion(.failure(SessionError.unacceptableStatusCode(response.statusCode, message)))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
        return task
    }
}

enum SessionError: Error {
    case noData(HTTPURLResponse)
    case noResponse
    case unacceptableStatusCode(Int, Message?)
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
}

extension SessionError {
    struct Message: Decodable {
        let documentationURL: URL
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case documentationURL = "documentation_url"
            case message
        }
    }
}
