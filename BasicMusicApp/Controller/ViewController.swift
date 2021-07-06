//
//  ViewController.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

  private var loadLocalTracks: LoadLocalTracks?
  private var parseMediaItem: ParseMediaItem?
  private var albums: [Album] = []
  private var addBtn: UIBarButtonItem!

  private lazy var tableView: UITableView = {
    let v = UITableView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.delegate = self
    v.dataSource = self
    v.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
    v.estimatedRowHeight = 132
    v.rowHeight = UITableView.automaticDimension
    v.tableFooterView = UIView()
    return v
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigatinoBar()
    self.setupView()
  }

  private func refreshData(resourceUrl: URL) {
    self.loadLocalTracks = LoadLocalTracks(url: resourceUrl)
    self.albums.append(self.loadLocalTracks!.album!)
    self.tableView.reloadData()
    self.setupView()
  }

  private func refreshData(mediaItems: [MPMediaItem]) {
    self.parseMediaItem = ParseMediaItem(mediaItems: mediaItems)
    self.albums.append(self.parseMediaItem!.album!)
    self.tableView.reloadData()
    self.setupView()
  }

  private func setupView() {
    self.view.addSubview(tableView)
    self.setupConstraints()
  }

  private func setupNavigatinoBar() {
    self.title = "Basic Music Player"
    self.addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onAddClick))
    self.navigationItem.rightBarButtonItem = addBtn
  }

  private func setupConstraints() {
    // UITableView
    NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                 tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                 tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
  }

  @objc func onAddClick() {
    #if targetEnvironment(simulator)
      let documentPicker =
          UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
      documentPicker.delegate = self
      present(documentPicker, animated: true, completion: nil)
    #else
      let mpPicker = MPMediaPickerController(mediaTypes: .music)
      mpPicker.delegate = self
      mpPicker.allowsPickingMultipleItems = true
      self.present(mpPicker, animated: true, completion: nil)
    #endif

  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell else {
      return UITableViewCell()
    }

    cell.album = albums[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = TrackListViewController(album: albums[indexPath.row])
    self.tableView.deselectRow(at: indexPath, animated: true)
    present(vc, animated: true, completion: nil)
  }
  
}

extension ViewController: UIDocumentPickerDelegate {
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    print("picked url is " , urls)
    self.loadLocalTracks = LoadLocalTracks(url: urls.first!)
    self.refreshData(resourceUrl: urls.first!)
  }
}

extension ViewController: MPMediaPickerControllerDelegate {
  func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
    print("mediaItemURL = ", mediaItemCollection.representativeItem?.assetURL)
    mediaPicker.dismiss(animated: true, completion: nil)
    self.refreshData(mediaItems: mediaItemCollection.items)
  }
}
