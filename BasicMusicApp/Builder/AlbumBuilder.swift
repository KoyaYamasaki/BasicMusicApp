//
//  AlbumBuilder.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation

class AlbumBuilder: Builder {
  typealias BuildType = Album
  private var _name: String = ""
  private var _artist: String = ""
  private var _image: String = ""
  private var _songs: [Song] = []

  var name: String {
    set(newValue) {
      self._name = newValue
    }
    get {
      return _name
    }
  }

  var artist: String {
    set(newValue) {
      self._artist = newValue
    }
    get {
      return _artist
    }
  }

  var image: String {
    set(newValue) {
      self._image = newValue
    }
    get {
      return _image
    }
  }

  var songs: [Song] {
    set(newValue) {
      self._songs = newValue
    }
    get {
      return self._songs
    }
  }

  func build() -> Album {
    return Album(name: _name, artist: _artist, image: _image, songs: _songs)
  }
}
