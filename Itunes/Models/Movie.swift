//
//  Movie.swift
//  Itunes
//
//  Created by Aristide LAUGA on 21/06/2023.
//

import Foundation

// MARK: - MovieResult
struct MovieResult: Codable {
  let resultCount: Int
  let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
  let wrapperType, kind: String
  let trackID: Int
  let artistName, trackName, trackCensoredName: String
  let trackViewURL: String
  let previewURL: String
  let artworkUrl30, artworkUrl60, artworkUrl100: String
  let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double
  let trackHDPrice, trackHDRentalPrice: Double
  let releaseDate: Date
  let collectionExplicitness, trackExplicitness: String
  let trackTimeMillis: Int
  let country, currency, primaryGenreName, contentAdvisoryRating: String
  let shortDescription, longDescription: String
  
  enum CodingKeys: String, CodingKey {
    case wrapperType, kind
    case trackID = "trackId"
    case artistName, trackName, trackCensoredName
    case trackViewURL = "trackViewUrl"
    case previewURL = "previewUrl"
    case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
    case collectionHDPrice = "collectionHdPrice"
    case trackHDPrice = "trackHdPrice"
    case trackHDRentalPrice = "trackHdRentalPrice"
    case releaseDate, collectionExplicitness, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription
  }
}
