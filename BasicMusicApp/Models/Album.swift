//
//  Album.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation

struct Album {
  private var _name: String
  private var _artist: String
  private var _image: String
  private var _songs: [Song]

  var name: String {
    return _name
  }

  var artist: String {
    return _artist
  }

  var image: String {
    return _image
  }

  var songs: [Song] {
    return _songs
  }

  init(name: String, artist: String, image: String, songs: [Song]) {
    self._name = name
    self._image = image
    self._artist = artist
    self._songs = songs
  }
}
