//
//  APIClient.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/19/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    func fetchUpcomingMovies(completion: @escaping (MovieGroup?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=acb5063b86a8efb1ba814b6ad605f578"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }

    func fetchNowPlayingMovies(completion: @escaping (MovieGroup?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=acb5063b86a8efb1ba814b6ad605f578"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode > 200 {
                    print("Error with network request: \(httpResponse)")
                    return
                }
            }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects,nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: ", error)
            }
            
        }
        dataTask.resume()
    }
}
