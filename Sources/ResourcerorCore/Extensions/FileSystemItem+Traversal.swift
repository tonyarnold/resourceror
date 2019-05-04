//  Copyright © 2019 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files

extension FileSystem.Item {
  struct ParentItemsSequence: Sequence, IteratorProtocol {
    private var nextItem: FileSystem.Item?
    private var stopWhen: (FileSystem.Item) -> Bool

    init(startingWith item: FileSystem.Item, stopWhen: @escaping (FileSystem.Item) -> Bool = { _ in false }) {
      self.nextItem = item
      self.stopWhen = stopWhen
    }

    init(for item: FileSystem.Item, stopWhen: @escaping (FileSystem.Item) -> Bool = { _ in false }) {
      self.nextItem = item.parent
      self.stopWhen = stopWhen
    }

    mutating func next() -> FileSystem.Item? {
      let result = nextItem

      if let result = result, self.stopWhen(result) {
        return nil
      }

      nextItem = result?.parent
      return result
    }
  }

  var parents: ParentItemsSequence {
    return ParentItemsSequence(for: self)
  }

  func parents(upTo: @escaping (FileSystem.Item) -> Bool) -> ParentItemsSequence {
    return ParentItemsSequence(for: self, stopWhen: upTo)
  }
}
