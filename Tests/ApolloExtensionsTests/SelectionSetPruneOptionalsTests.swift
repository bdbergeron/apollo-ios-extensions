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

    // Edge
    XCTAssertNotEqual(objectFromGeneratedInitializer, parsedObject)
    XCTAssertEqual(objectFromGeneratedInitializer.__typename, parsedObject.__typename)
    XCTAssertEqual(objectFromGeneratedInitializer.__objectType, parsedObject.__objectType)

    // Node
    XCTAssertNotEqual(objectFromGeneratedInitializer.node, parsedObject.node)
    XCTAssertEqual(objectFromGeneratedInitializer.node.id, parsedObject.node.id)
    XCTAssertEqual(objectFromGeneratedInitializer.node.name, parsedObject.node.name)
    XCTAssertEqual(objectFromGeneratedInitializer.node.__typename, parsedObject.node.__typename)
    XCTAssertEqual(objectFromGeneratedInitializer.node.__objectType, parsedObject.node.__objectType)

    // So what's driving the inequality? The underlying `DataDict`
    XCTAssertNotEqual(objectFromGeneratedInitializer.__data, parsedObject.__data)
    XCTAssertNotEqual(objectFromGeneratedInitializer.node.__data, parsedObject.node.__data)

    let pruned = objectFromGeneratedInitializer.pruneOptionals()

    // And now everything's equal as one would expect
    XCTAssertEqual(pruned, parsedObject)
  }
}
