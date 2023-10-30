// Created by Brad Bergeron on 10/30/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - MockApolloClientTests

final class MockApolloClientTests: XCTestCase {

  // MARK: Internal

  override func setUp() {
    apolloClient = MockApolloClient()
  }

  func test_fetch_failsWithNoResultSetError() {
    let expectation = expectation(description: #function)
    apolloClient.fetch(query: TestQuery()) { result in
      expectation.fulfill()
      switch result {
      case .success:
        XCTFail("Should fail.")
      case .failure(let error):
        guard case .noResultSet = error as? MockApolloClient.Error else {
          XCTFail("Unexpected error: \(error)")
          return
        }
      }
    }
    wait(for: [expectation], timeout: 1.0)
  }

  func test_fetch_failsWithInvalidResultTypeForOperationError() {
    let subscription = TestSubscription()
    let data = TestSubscription.Data(people: .init(edges: []))
    let subscriptionResult = GraphQLResult(data: data)

    apolloClient.fetchResult = { _ in
      .success(subscriptionResult)
    }

    let expectation = expectation(description: #function)
    apolloClient.fetch(query: TestQuery()) { result in
      expectation.fulfill()
      switch result {
      case .success:
        XCTFail("Should fail.")
      case .failure(let error):
        guard case .invalidResultTypeForOperation(let operation, let result) = error as? MockApolloClient.Error else {
          XCTFail("Unexpected error: \(error)")
          return
        }
        XCTAssertEqual(operation.hashValue, subscription.hashValue)
        XCTAssertEqual(result as? GraphQLResult<TestSubscription.Data>, subscriptionResult)
      }
    }
    wait(for: [expectation], timeout: 1.0)
  }

  // MARK: Private

  private var apolloClient: MockApolloClient! // swiftlint:disable:this implicitly_unwrapped_optional

}
