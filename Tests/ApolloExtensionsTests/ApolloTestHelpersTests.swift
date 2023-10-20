// Created by Brad Bergeron on 10/19/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - ApolloTestHelpersTests

final class ApolloTestHelpersTests: XCTestCase {
  func test_mockedJSONResponse_failsWithInvalidJSONError() throws {
    let url = try XCTUnwrap(Bundle.module.url(forResource: "items_invalid_json", withExtension: "json"))
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
    let url = try XCTUnwrap(Bundle.module.url(forResource: "items", withExtension: "json"))
    let response = try GraphQLResult.mockedJSONResponse(
      for: TestQuery(),
      jsonURL: url)
    let data = try XCTUnwrap(response.data)
    XCTAssertEqual(data.items.edges.first?.node.__typename, "Item")
    XCTAssertEqual(data.items.edges.first?.node.id, "1")
    XCTAssertEqual(data.items.edges.first?.node.name, "Brad")
  }

  func test_dataDict_debugDescription() {
    let dataDict = TestQuery.Data.Items.Edge.Node(id: "1", name: "Brad").__data
    let expected: [(key: String, value: AnyHashable)] = [
      (key: "__typename", value: "Item"),
      (key: "id", value: "1"),
      (key: "name", value: Optional("Brad")),
    ]
    XCTAssertEqual(dataDict.description, expected.description)
  }

}
