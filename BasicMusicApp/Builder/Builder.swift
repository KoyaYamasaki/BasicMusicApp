//
//  Builder.swift
//  BasicMusicApp
//
//  Created by 山崎宏哉 on 2021/06/03.
//

import Foundation

protocol Builder {
  associatedtype BuildType
  func build() -> BuildType
}
