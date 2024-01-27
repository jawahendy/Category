//
//  File.swift
//  
//
//  Created by Hendy Nurfrianto on 25/01/24.
//

import Foundation
import Core

public struct CategoryTransformer: Mapper {

    
  public typealias Response = [CategoryGamesResponses]
  public typealias Domain = [CategoryGamesModels]
  public typealias Responseaddfav = [AddsFavortResponses]
  public typealias Domainaddfav = [AddfavoritModels]

  public init() {}

    public func transformEntityToDomain(entity: [CategoryGamesResponses]) -> [CategoryGamesModels] {
      return entity.map { result in
          return CategoryGamesModels(
              adult: result.adult!,
              backdropPath: result.backdrop_path ?? "",
              id: result.id!,
              originalLanguage: result.originalLanguage ?? "",
              originalTitle: result.original_title ?? "",
              overview: result.overview ?? "",
              popularity: result.popularity!,
              posterPath: result.poster_path ?? "",
              releaseDate: result.release_date ?? "",
              title: result.title ?? "",
              voteAverage: result.vote_average ?? 0,
              voteCount: result.vote_count ?? 0
          )
      }
    }
    
    public func transformEntityToDomainAddfav(entity: [AddsFavortResponses]) -> [AddfavoritModels] {
      return entity.map { result in
          return AddfavoritModels(success: result.success, status_message: result.status_message ?? "", status_code: result.status_code)
      }
    }

}
