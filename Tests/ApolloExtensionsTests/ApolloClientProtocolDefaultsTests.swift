// Created by Brad Bergeron on 10/19/23.

import Apollo
import XCTest

@testable import ApolloExtensions

// MARK: - ApolloClientProtocolDefaultsTests

final class ApolloClientProtocolDefaultsTests: XCTestCase {

  // MARK: Internal

  override func setUp() {
    apolloClient = MockApolloClient()
  }

  func test_clearCache() {
    apolloClient.clearCacheResult = { queue in
      XCTAssertEqual(queue, .main)
      return .success(())
    }

    let expectation = expectation(description: #function)
    apolloClient.clearCache { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }

  func test_fetch() {
    apolloClient.fetchResult = { parameters in
      XCTAssertEqual(parameters.cachePolicy, .default)
      XCTAssertEqual(parameters.contextIdentifier, nil)
      XCTAssertNil(parameters.context)
      XCTAssertEqual(parameters.queue, .main)
      let data = TestQuery.Data(people: .init(edges: []))
      return .success(GraphQLResult(data: data))
    }

    let expectation = expectation(description: #function)
    apolloClient.fetch(query: TestQuery()) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }

  func test_watch() {
    apolloClient.watchResult = { parameters in
      XCTAssertEqual(parameters.cachePolicy, .default)
      XCTAssertNil(parameters.context)
      XCTAssertEqual(parameters.callbackQueue, .main)
      let data = TestQuery.Data(people: .init(edges: []))
      return .success(GraphQLResult(data: data))
    }

    let expectation = expectation(description: #function)
    _ = apolloClient.watch(query: TestQuery()) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }

  func test_perform() {
    apolloClient.performResult = { parameters in
      XCTAssertEqual(parameters.publishResultToStore, true)
      XCTAssertNil(parameters.context)
      XCTAssertEqual(parameters.queue, .main)
      let data = TestMutation.Data(updatePerson: .init(id: "1", name: "Brad"))
      return .success(GraphQLResult(data: data))
    }

    let mutation = TestMutation(id: "1", updates: .init(name: "Brad"))
    let expectation = expectation(description: #function)
    apolloClient.perform(mutation: mutation) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }

  func test_upload() {
    apolloClient.uploadResult = { parameters in
      XCTAssertEqual(parameters.files, [])
      XCTAssertNil(parameters.context)
      XCTAssertEqual(parameters.queue, .main)
      let data = TestMutation.Data(updatePerson: .init(id: "1", name: "Brad"))
      return .success(GraphQLResult(data: data))
    }

    let mutation = TestMutation(id: "1", updates: .init(name: "Bradley"))
    let expectation = expectation(description: #function)
    apolloClient.upload(operation: mutation, files: []) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }

  func test_subscribe() {
    let apolloClient = MockApolloClient()
    apolloClient.subscribeResult = { parameters in
      XCTAssertNil(parameters.context)
      XCTAssertEqual(parameters.queue, .main)
      let data = TestSubscription.Data(people: .init(edges: []))
      return .success(GraphQLResult(data: data))
    }

    let subscription = TestSubscription()
    let expectation = expectation(description: #function)
    _ = apolloClient.subscribe(subscription: subscription) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.0)
  }

  // MARK: Private

  private var apolloClient: MockApolloClient! // swiftlint:disable:this implicitly_unwrapped_optional
}
