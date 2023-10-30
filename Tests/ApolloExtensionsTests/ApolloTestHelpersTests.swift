// Created by Brad Bergeron on 10/19/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - ApolloTestHelpersTests

final class ApolloTestHelpersTests: XCTestCase {
  func test_mockedJSONResponse_failsWithInvalidJSONError() throws {
    let url = try XCTUnwrap(Bundle.module.url(forResource: "invalid_json", withExtension: "json"))
    do {
      _ = try GraphQLResult.mockedJSONResponse(
        for: TestQuery(),
        jsonURL: url)
    } catch let error as JSONResponseParsingInterceptor.JSONResponseParsingError {
      guard case .couldNotParseToJSON = error else {
        XCTFail("Unexpected error: \(error)")
        return
      }
    }
  }

  func test_mockedJSONResponse() throws {
    let url = try XCTUnwrap(Bundle.module.url(forResource: "people", withExtension: "json"))
    let response = try GraphQLResult.mockedJSONResponse(
      for: TestQuery(),
      jsonURL: url)
    let data = try XCTUnwrap(response.data)
    XCTAssertEqual(data.people.edges.count, 2)
    XCTAssertEqual(data.people.edges[0].node.__typename, "Person")
    XCTAssertEqual(data.people.edges[0].node.id, "1")
    XCTAssertEqual(data.people.edges[0].node.name, "Bradley")
    XCTAssertEqual(data.people.edges[0].node.nickname, "Brad")
    XCTAssertEqual(data.people.edges[0].node.age, 34)
    XCTAssertEqual(data.people.edges[1].node.__typename, "Person")
    XCTAssertEqual(data.people.edges[1].node.id, "2")
    XCTAssertEqual(data.people.edges[1].node.name, "Noah")
    XCTAssertEqual(data.people.edges[1].node.nickname, nil)
    XCTAssertEqual(data.people.edges[1].node.age, nil)

    let person1 = Person(id: "1", name: "Bradley", nickname: "Brad", age: 34)
    XCTAssertEqual(data.people.edges[0].node.fragments.person, person1.pruneOptionals())

    let person2 = Person(id: "2", name: "Noah", nickname: nil, age: nil)
    XCTAssertEqual(data.people.edges[1].node.fragments.person, person2.pruneOptionals())

    let people = PersonCollection(edges: [
      .init(node: .init(id: "1", name: "Bradley", nickname: "Brad", age: 34)),
      .init(node: .init(id: "2", name: "Noah", nickname: nil, age: nil)),
    ])
    XCTAssertEqual(data.people.fragments.personCollection, people.pruneOptionals())
  }

  func test_dataDict_debugDescription() {
    let dataDict = Person(id: "1", name: "Brad").__data
    let expected: [(key: String, value: AnyHashable)] = [
      (key: "__typename", value: "Person"),
      (key: "age", value: AnyHashable(AnyHashable?.none)),
      (key: "id", value: "1"),
      (key: "name", value: "Brad"),
      (key: "nickname", value: AnyHashable(AnyHashable?.none)),
    ]
    XCTAssertEqual(dataDict.description, expected.description)
  }

}
