// Created by Brad Bergeron on 10/19/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - SelectionSetPruneOptionalsTests

final class SelectionSetPruneOptionalsTests: XCTestCase {
  func test_pruneOptionals_notSpecified() throws {
    let parsedPerson = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": nil,
        "age": nil,
      ])
    let personFromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley")
    XCTAssertEqual(personFromGeneratedInitializer, parsedPerson)
    XCTAssertNotEqual(personFromGeneratedInitializer.__data, parsedPerson.__data)

    let pruned = personFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedPerson)
    XCTAssertEqual(pruned.__data, parsedPerson.__data)
  }

  func test_pruneOptionals_withOptional() throws {
    let parsedPerson = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": "Brad",
        "age": 34,
      ])
    let personFromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: .some("Brad"),
      age: .some(34))
    XCTAssertEqual(personFromGeneratedInitializer, parsedPerson)
    XCTAssertNotEqual(personFromGeneratedInitializer.__data, parsedPerson.__data)

    let pruned = personFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedPerson)
    XCTAssertEqual(pruned.__data, parsedPerson.__data)
  }

  func test_pruneOptionals_withNone() throws {
    let parsedPerson = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": nil,
        "age": nil,
      ])
    let personFromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: .none,
      age: .none)
    XCTAssertEqual(personFromGeneratedInitializer, parsedPerson)
    XCTAssertNotEqual(personFromGeneratedInitializer.__data, parsedPerson.__data)

    let pruned = personFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedPerson)
    XCTAssertEqual(pruned.__data, parsedPerson.__data)
  }

  func test_pruneOptionals_withNil() throws {
    let parsedPerson = try Person(
      data: [
        "__typename": "Person",
        "id": "1",
        "name": "Bradley",
        "nickname": nil,
        "age": nil,
      ])
    let personFromGeneratedInitializer = Person(
      id: "1",
      name: "Bradley",
      nickname: nil,
      age: nil)
    XCTAssertEqual(personFromGeneratedInitializer, parsedPerson)
    XCTAssertNotEqual(personFromGeneratedInitializer.__data, parsedPerson.__data)

    let pruned = personFromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsedPerson)
    XCTAssertEqual(pruned.__data, parsedPerson.__data)
  }

  func test_pruneOptionals_nested_withOptional() throws {
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
            ] as [String: AnyHashable?],
          ] as [String: AnyHashable?],
          [
            "__typename": "PersonCollectionEdge",
            "node": [
              "__typename": "Person",
              "id": "2",
              "name": "Christopher",
              "nickname": nil,
              "age": 32,
            ] as [String: AnyHashable?],
          ] as [String: AnyHashable?],
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
            age: 32)),
      ])

    XCTAssertEqual(fromGeneratedInitializer, parsed)
    XCTAssertNotEqual(fromGeneratedInitializer.__data, parsed.__data)

    let pruned = fromGeneratedInitializer.pruneOptionals()
    XCTAssertEqual(pruned, parsed)
    XCTAssertEqual(pruned.__data, parsed.__data)
  }
}
