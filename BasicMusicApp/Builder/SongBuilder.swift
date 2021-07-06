//
//  SongBuilder.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation
class SongBuilder: Builder {
  typealias BuildType = Song

  private var _name: String = ""
  private var _image: String = ""
  private var _artist: String = ""
  private var _albumName: String = ""
  private var _type: String = ""
  private var _trackNumber: Int = 0
  private var _fileURL = URL(fileURLWithPath: "")

  var name: String {
    set(newValue) {
      self._name = newValue
    }
    get {
      return _name
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

  var artist: String {
    set(newValue) {
      self._artist = newValue
    }
    get {
      return _artist
    }
  }

  var albumName: String {
    set(newValue) {
      self._albumName = newValue
    }
    get {
      return _albumName
    }
  }


  var type: String {
    set(newValue) {
      self._type = newValue
    }
    get {
      return _type
    }
  }

  var trackNumber: Int {
    set(newValue) {
      self._trackNumber = newValue
    }
    get {
      return _trackNumber
    }
  }

  var fileURL: URL {
    set(newValue) {
      self._fileURL = newValue
    }
    get {
      return _fileURL
    }
  }

  func build() -> Song {
    return Song(name: _name,
                image: _image,
                artist: _artist,
                albumName: _albumName,
                type: _type,
                trackNumber: _trackNumber,
                fileURL: _fileURL)
  }

}
