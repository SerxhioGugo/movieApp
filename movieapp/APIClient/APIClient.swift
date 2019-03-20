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
    
    func fetchUpcomingTvShows(completion: @escaping (MovieGroup?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=acb5063b86a8efb1ba814b6ad605f578"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchUpcomingMovies(completion: @escaping (MovieGroup?, Error?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=acb5063b86a8efb1ba814b6ad605f578"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchMovieGroup(urlString: String, completion: @escaping (MovieGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        
        print("T is type: ", T.self)
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects,nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: ", error)
            }
            
            }.resume()
    }
}
