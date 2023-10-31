// Created by Brad Bergeron on 10/19/23.

import XCTest

@testable import ApolloExtensions

// MARK: - SelectionSetInitWithDataTests

final class SelectionSetInitWithDataTests: XCTestCase {
  func test_initWithData_equalToGeneratedInitializerObject_noNilFields() throws {
    let parsed = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": "Brad",
        "age": 34,
      ])
    let fromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: "Brad",
      age: 34)
    XCTAssertEqual(fromGeneratedInitializer, parsed)
  }

  func test_initWithData_equalToGeneratedInitializerObject_nilFields() throws {
    let parsed = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": nil,
        "age": nil,
      ])
    let fromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: nil,
      age: nil)
    XCTAssertEqual(fromGeneratedInitializer, parsed)
  }

  func test_initWithData_equalToGeneratedInitializerObject_nestedObjects() throws {
    let parsed = try PersonCollection(
      data: [
        "__typename": "PersonCollection",
        "edges": [
          [
            "__typename": "PersonCollectionEdge",
            "node": [
              "__typename": "Person",
              "id": "1",
              "name": "Bradley",
              "nickname": "Brad",
              "age": 34,
            ] as [String: AnyHashable],
          ] as [String: AnyHashable],
          [
            "__typename": "PersonCollectionEdge",
            "node": [
              "__typename": "Person",
              "id": "2",
              "name": "Christopher",
              "nickname": "Chris",
              "age": 32,
            ] as [String: AnyHashable],
          ] as [String: AnyHashable],
        ]
      ])
    let fromGeneratedInitializer = PersonCollection(
      edges: [
        .init(
          node: .init(
            id: "1",
            name: "Bradley",
            nickname: "Brad",
            age: 34)),
        .init(
          node: .init(
            id: "2",
            name: "Christopher",
            nickname: "Chris",
            age: 32)),
      ])
    XCTAssertEqual(fromGeneratedInitializer, parsed)
  }
}
