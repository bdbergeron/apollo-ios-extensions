// Created by Brad Bergeron on 10/18/23.

#if DEBUG

import ApolloAPI
import Foundation

extension SelectionSet {
  public func pruneOptionals() -> Self {
    Self(_dataDict: __data.pruneOptionals())
  }
}

extension DataDict {
  fileprivate func pruneOptionals() -> Self {
    let prunedData = _data.mapValues { value in
      if let dataDict = value as? DataDict {
        return AnyHashable(dataDict.pruneOptionals())
      }
      guard let optionalValue = value.base as? AnyHashable? else {
        return value
      }
      return optionalValue ?? AnyHashable?.none
    }
    return .init(data: prunedData, fulfilledFragments: _fulfilledFragments)
  }
}

#endif
