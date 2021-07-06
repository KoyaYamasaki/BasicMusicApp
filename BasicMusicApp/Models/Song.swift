//
//  Song.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation

struct Song {
  private var _name: String
  private var _image: String
  private var _artist: String
  private var _albumName: String
  private var _type: String
  private var _trackNumber: Int
  private var _fileURL: URL

  var name: String {
    return _name
  }

  var image: String {
    return _image
  }

  var artist: String {
    return _artist
  }

  var albumName: String {
    return _albumName
  }

  var type: String {
    return _type
  }

  var trackNumber: Int {
    return _trackNumber
  }

  var fileURL: URL {
    return _fileURL
  }

  init(name: String,
       image: String,
       artist: String,
       albumName: String,
       type: String,
       trackNumber: Int,
       fileURL: URL) {
    self._name = name
    self._image = image
    self._artist = artist
    self._albumName = albumName
    self._type = type
    self._trackNumber = trackNumber
    self._fileURL = fileURL
  }
}
