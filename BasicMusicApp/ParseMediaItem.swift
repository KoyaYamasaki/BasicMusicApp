//
//  ParseMediaItem.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/05.
//

import Foundation
import MediaPlayer

class ParseMediaItem {
  var album: Album?

  init(mediaItems: [MPMediaItem]) {
    var songs: [Song] = []
    for mediaItem in mediaItems {
      let songBuilder = SongBuilder()
      songBuilder.name = mediaItem.title ?? ""
      songBuilder.artist = mediaItem.artist ?? ""
      songBuilder.albumName = mediaItem.albumTitle ?? ""
      songBuilder.trackNumber = mediaItem.albumTrackNumber
      songBuilder.type = mediaItem.genre ?? "unknown"
      songBuilder.fileURL = mediaItem.assetURL!
      let song = songBuilder.build()
      print("song = ", song)
      songs.append(song)
    }

    album = createAlbum(songs: songs)
  }

  func createAlbum(songs: [Song]) -> Album {
    let albumBuilder = AlbumBuilder()
    if !songs.isEmpty {
      albumBuilder.name = songs.first!.albumName
      albumBuilder.artist = songs.first!.artist
      albumBuilder.songs = songs
    }
    
    return albumBuilder.build()
  }
}
