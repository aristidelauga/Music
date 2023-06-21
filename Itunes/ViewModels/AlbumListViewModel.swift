//
//  AlbumListViewModel.swift
//  Itunes
//
//  Created by Aristide LAUGA on 30/05/2023.
//

import Combine
import Foundation


// https://itunes.apple.com/search?term=jack+johnson
// https://itunes.apple.com/search?term=michael+jackson&entity=album&limit=5&offset=10
// https://itunes.apple.com/search?term=michael+jackson&entity=song&limit=5
// https://itunes.apple.com/search?term=Dhanush&entity=movie&limit=5
// https://itunes.apple.com/search?term=jim+jones&country=ca

class AlbumListViewModel: ObservableObject {
  
  enum State: Equatable {
    case good
    case isLoading
    case loadedAll
    case error(String)
  }
  
  
  @Published var searchTerm: String = ""
  @Published var albums: [Album] = []
  @Published var state: State = .good {
    didSet {
      print("State changed to: \(state)")
    }
  }
  
  let limit: Int = 20
  var page: Int = 0
  
  var subscriptions = Set<AnyCancellable>()
  
  init() {
    $searchTerm
      .dropFirst()
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
      .sink { [weak self] term in
        self?.state = .good
        self?.albums = []
        self?.page = 0
        self?.fetchAlbums(for: term)
      }.store(in: &subscriptions)
  }
  
  
  func fetchAlbums(for searchTerm: String) {
    
    guard !searchTerm.isEmpty else {
      return
    }
    
    guard state == State.good else {
      return
    }
    
    let offset = page * limit
    state = State.isLoading
    
    guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        DispatchQueue.main.async {
          self.state = .error("Could not load: \(error.localizedDescription)")
        }
      } else if let data = data {
        do {
          let result = try JSONDecoder().decode(AlbumResult.self, from: data)
          DispatchQueue.main.async {
            for album in result.results {
              self.albums.append(album)
            }
            self.page += 1
            self.state = (result.results.count == self.limit) ? .good : .loadedAll
          }
        } catch {
          DispatchQueue.main.async {
            self.state = .error("Could not get data: \(error.localizedDescription)")
          }
        }
      }
      //
      //      DispatchQueue.main.async {
      //        self.state = .good
      //      }
      
    }.resume()
  }
  
  func loadMore() {
    fetchAlbums(for: searchTerm)
  }
  
}
