//
//  File.swift
//  
//
//  Created by Hendy Nurfrianto on 25/01/24.
//

import Foundation
import Core
import Combine

// 1
public struct GetCategoriesRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
// 2
RemoteDataSource.Response == [CategoryGamesResponses],
Transformer.Response == [CategoryGamesResponses],
Transformer.Responseaddfav == [AddsFavortResponses],
Transformer.Domainaddfav == [AddfavoritModels],
Transformer.Domain == [CategoryGamesModels] {
    
    

  // 3
  public typealias Request = Any
  public typealias Response = [CategoryGamesModels]
  public typealias Responseaddfav = [AddfavoritModels]

  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {

      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }

  // 4
  public func execute(request: Any?) -> AnyPublisher<[CategoryGamesModels], Error> {
    return _remoteDataSource.getCategories(request: nil)
      .flatMap { result -> AnyPublisher<[CategoryGamesModels], Error> in
        if result.isEmpty {
          return _remoteDataSource.getCategories(request: nil)
            .catch { _ in _remoteDataSource.getCategories(request: nil) }
            .flatMap { _ in _remoteDataSource.getCategories(request: nil)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _remoteDataSource.getCategories(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
    
    public func executeaddfav(request: Request?, id: Int, fav: Bool) -> AnyPublisher<[AddfavoritModels], Error>  {
      return _remoteDataSource.addCategoriesFavorite(request: nil, id: id, fav: fav)
        .flatMap { result -> AnyPublisher<[AddfavoritModels], Error> in
            if result != nil {
            return _remoteDataSource.addCategoriesFavorite(request: nil, id: id, fav: fav)
                  .catch { _ in _remoteDataSource.addCategoriesFavorite(request: nil, id: id, fav: fav) }
                  .flatMap { _ in _remoteDataSource.addCategoriesFavorite(request: nil, id: id, fav: fav)
                          .map { _mapper.transformEntityToDomainAddfav(entity: $0 as! Transformer.Responseaddfav) }
              }
              .eraseToAnyPublisher()
          } else {
            return _remoteDataSource.addCategoriesFavorite(request: nil, id: id, fav: fav)
                  .map { _mapper.transformEntityToDomainAddfav(entity: $0 as! Array<AddsFavortResponses>) }
              .eraseToAnyPublisher()
          }
        }.eraseToAnyPublisher()
    }
}
