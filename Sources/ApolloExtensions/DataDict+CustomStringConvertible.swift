// Created by Brad Bergeron on 10/17/23.

import ApolloAPI
import Foundation

extension DataDict: @retroactive CustomStringConvertible {
  public var description: String {
    _data.sorted { $0.key < $1.key }.description
  }
}
