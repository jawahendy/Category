//
//  File.swift
//  
//
//  Created by Hendy Nurfrianto on 25/01/24.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetCategoriesRemoteDataSource : DataSource {
    
  
  public typealias Responseaddfav = [AddsFavortResponses]
    
  public typealias Request = Any

  public typealias Response = [CategoryGamesResponses]

  private let _endpoint: String

  public init(endpoint: String) {
    _endpoint = endpoint
  }
    
    public func getCategories(request: Request?) -> AnyPublisher<[CategoryGamesResponses], Error> {
      return Future<[CategoryGamesResponses], Error> { completion in
        if let url = URL(string: _endpoint) {
          AF.request(url,headers: ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNjdhYTZjYWJmMzg4ODM5NmEyZTVjN2JjZDEzYTRjYyIsInN1YiI6IjYyNTZjNTJjMGMyNzEwMDIyOTVkOTgyMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Zv3FvPx_J7__Mt2wyFZC4dXZ8NwW94dyO2F-TlqZHaA",
                                   "Content-Type": "application/json"])
            .validate()
            .responseDecodable(of: CategoriesGamesResponses.self) { response in
              switch response.result {
              case .success(let value):
                completion(.success(value.results))
              case .failure:
                completion(.failure(URLError.invalidResponse))
              }
            }
        }
      }.eraseToAnyPublisher()
    }
    
    public func addCategoriesFavorite(request: Request?, id: Int, fav: Bool) -> AnyPublisher<[AddsFavortResponses], Error> {
        return Future<[AddsFavortResponses], Error> { completion in
          if let url = URL(string: "https://api.themoviedb.org/3/account/12232149/favorite") {
              let parameters = [
                  "media_type": "movie",
                  "media_id": id,
                  "favorite": fav
              ]
              print(parameters)
              AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default,headers: ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNjdhYTZjYWJmMzg4ODM5NmEyZTVjN2JjZDEzYTRjYyIsInN1YiI6IjYyNTZjNTJjMGMyNzEwMDIyOTVkOTgyMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Zv3FvPx_J7__Mt2wyFZC4dXZ8NwW94dyO2F-TlqZHaA",
                                     "Content-Type": "application/json"])
              .responseJSON { response in
                  print(response)
              }
          }
        }.eraseToAnyPublisher()
      }
}

