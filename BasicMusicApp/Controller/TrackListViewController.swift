//
//  TrackListViewController.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/05.
//

import Foundation
import UIKit

final class TrackListViewController: UIViewController {

  private lazy var tableView: UITableView = {
    let v = UITableView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.delegate = self
    v.dataSource = self
    v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    v.rowHeight = UITableView.automaticDimension
    v.tableFooterView = UIView()
    return v
  }()

  private var album: Album?

  init(album: Album) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }

  private func setupView() {
    self.view.addSubview(tableView)
    self.setupConstraints()
  }

  private func setupConstraints() {
    // UITableView
    NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                 tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                 tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
  }
}

extension TrackListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return album?.songs.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = album?.songs[indexPath.row].name ?? "unknown"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = MusicPlayerViewController(album: album!, trackNumber: indexPath.row)
    self.tableView.deselectRow(at: indexPath, animated: true)
    present(vc, animated: true, completion: nil)
  }
}
