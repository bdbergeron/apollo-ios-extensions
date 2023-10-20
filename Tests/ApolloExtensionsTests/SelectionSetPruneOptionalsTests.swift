// Created by Brad Bergeron on 10/19/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - SelectionSetPruneOptionalsTests

final class SelectionSetPruneOptionalsTests: XCTestCase {
  func test_pruneOptionals_withOptional() throws {
    let parsedObject = try TestQuery.Data.Items.Edge(
      data: [
        "__typename": "ItemCollectionEdge",
        "node": [
          "__typename": "Item",
          "id": "3EEDDC8E-0CAA-40D4-8509-580AFF80A83B",
          "name": "Alta Ski Area",
        ],
      ])
    let objectFromGeneratedInitializer = TestQuery.Data.Items.Edge(
      node: .init(
        id: "3EEDDC8E-0CAA-40D4-8509-580AFF80A83B",
        name: "Alta Ski Area"))
    XCTAssertNotEqual(objectFromGeneratedInitializer, parsedObject)
    let pruned = objectFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedObject)
  }

  func test_pruneOptionals_withNull() throws {
    let parsedObject = try TestQuery.Data.Items.Edge(
      data: [
        "__typename": "ItemCollectionEdge",
        "node": [
          "__typename": "Item",
          "id": "3EEDDC8E-0CAA-40D4-8509-580AFF80A83B",
          "name": nil,
        ],
      ])
    let objectFromGeneratedInitializer = TestQuery.Data.Items.Edge(
      node: .init(
        id: "3EEDDC8E-0CAA-40D4-8509-580AFF80A83B",
        name: nil))
    XCTAssertNotEqual(objectFromGeneratedInitializer, parsedObject)
    let pruned = objectFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedObject)
  }
}
