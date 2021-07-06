//
//  MusicPlayerViewController.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation
import UIKit

final class MusicPlayerViewController: UIViewController {
  var album: Album
  var startIndex: Int

  private lazy var mediaPlayer: MediaPlayer = {
    let v = MediaPlayer(album: album, playingIndex: startIndex)
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()

  init(album: Album, trackNumber: Int) {
    self.album = album
    self.startIndex = trackNumber
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    mediaPlayer.play()
    UIApplication.shared.isIdleTimerDisabled = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    mediaPlayer.stop()
    UIApplication.shared.isIdleTimerDisabled = false
  }

  private func setupView() {
    addBlurredView()
    view.addSubview(mediaPlayer)

    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
      mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  private func addBlurredView() {
    if UIAccessibility.isReduceMotionEnabled {
      self.view.backgroundColor = UIColor.clear
      let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
      let blurEffctView = UIVisualEffectView(effect: blurEffect)
      blurEffctView.frame = self.view.bounds
      blurEffctView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

      view.addSubview(blurEffctView)
    } else {
      view.backgroundColor = UIColor.black
    }
  }
}
