//
//  LoadLocalTracks.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation
import MediaPlayer
import AVFoundation


class LoadLocalTracks {
  var album: Album?

  init(url: URL) {
    let trackList = getFileInfoListInDir(dirName: url.path)
    var songs: [Song] = []
    for track in trackList {
      songs.append(createSong(trackName: track, trackURL: url.appendingPathComponent(track)))
    }
    songs.sort(by: { $0.trackNumber < $1.trackNumber })
    album = createAlbum(albumDir: url, songs: songs)
  }

  func getFileInfoListInDir(dirName: String) -> [String] {
    let fileManager = FileManager.default
    var files: [String] = []
    do {
      files = try fileManager.contentsOfDirectory(atPath: dirName)
        
    } catch {
        print("no files found")
        return files
    }
    print(files)
    return files
  }

  func createAlbum(albumDir: URL, songs: [Song]) -> Album {
    let albumBuilder = AlbumBuilder()
    if !songs.isEmpty {
      albumBuilder.name = songs.first!.albumName
      albumBuilder.artist = songs.first!.artist
      albumBuilder.songs = songs
    }
    
    return albumBuilder.build()
  }

  func createSong(trackName: String, trackURL: URL) -> Song {
  
    let asset = AVAsset(url: trackURL)
    let avPlayerItem = AVPlayerItem(asset: asset)
    let metadataList = avPlayerItem.asset.metadata
    let songBuilder = SongBuilder()
    let strArray = trackName.components(separatedBy: " ")
    if let trackNumber = Int(strArray[0]) {
      songBuilder.trackNumber = trackNumber
    }
    songBuilder.fileURL = trackURL
    for item in metadataList {
      if let stringValue = item.value {
        if item.commonKey?.rawValue == "title" {
//          print("title = ", stringValue)
          songBuilder.name = stringValue as! String
        }
        if item.commonKey?.rawValue  == "artist" {
//          print("artist = ", stringValue)
          songBuilder.artist = stringValue as! String
        }
        if item.commonKey?.rawValue  == "albumName" {
//          print("albumName = ", stringValue)
          songBuilder.albumName = stringValue as! String
        }
        if item.commonKey?.rawValue  == "type" {
//          print("type = ", stringValue)
          songBuilder.type = stringValue as! String
        }
      }
    }

    return songBuilder.build()
  }
}
