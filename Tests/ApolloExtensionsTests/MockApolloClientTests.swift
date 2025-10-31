// Created by Brad Bergeron on 10/30/23.

import Apollo
import ApolloExtensionsTestSchema
import Testing

@testable import ApolloExtensions

// MARK: - MockApolloClientTests

@Suite
struct MockApolloClientTests {

  // MARK: Lifecycle

  init() {
    apolloClient = MockApolloClient()
  }

  // MARK: Internal

  @Test
  func fetch_failsWithNoResultSetError() async throws {
    do {
      _ = try await apolloClient.fetch(query: TestQuery())
      Issue.record("Should fail.")
    } catch {
      guard case .noResultSet = error as? MockApolloClient.Error else {
        Issue.record(error, "Unexpected error.")
        return
      }
    }
  }

  @Test
  func fetch_failsWithMockedError() async throws {
    struct TestError: Error { }
    await apolloClient.registerResult(
      .failure(TestError()),
      for: TestQuery.self
    )
    do {
      _ = try await apolloClient.fetch(query: TestQuery())
      Issue.record("Should fail.")
    } catch {
      guard error is TestError else {
        Issue.record(error, "Unexpected error.")
        return
      }
    }
  }

  @Test
  func fetch_succeedsWithMockedSuccessResponse() async throws {
    let mockedResponseData = TestQuery.Data(people: .init(edges: []))
    await apolloClient.registerResult(
      .success(.init(
        data: mockedResponseData,
        extensions: nil,
        errors: nil,
        source: .server,
        dependentKeys: nil
      )),
      for: TestQuery.self
    )
    let response = try await apolloClient.fetch(query: TestQuery())
    #expect(response.data == mockedResponseData)
    #expect(response.errors == nil)
  }

  @Test
  func perform_failsWithNoResultSetError() async throws {
    do {
      _ = try await apolloClient.perform(mutation: TestMutation(
        id: "1",
        updates: UpdatePersonMutationInput(name: "Brad")
      ))
      Issue.record("Should fail.")
    } catch {
      guard case .noResultSet = error as? MockApolloClient.Error else {
        Issue.record(error, "Unexpected error.")
        return
      }
    }
  }

  @Test
  func perform_failsWithMockedError() async throws {
    struct TestError: Error { }
    await apolloClient.registerResult(
      .failure(TestError()),
      for: TestMutation.self
    )
    do {
      _ = try await apolloClient.perform(mutation: TestMutation(
        id: "1",
        updates: UpdatePersonMutationInput(name: "Brad")
      ))
      Issue.record("Should fail.")
    } catch {
      guard error is TestError else {
        Issue.record(error, "Unexpected error.")
        return
      }
    }
  }

  @Test
  func perform_succeedsWithMockedSuccessResponse() async throws {
    let mockedResponseData = TestMutation.Data(updatePerson: .init(id: "1", name: "Brad"))
    await apolloClient.registerResult(
      .success(.init(
        data: mockedResponseData,
        extensions: nil,
        errors: nil,
        source: .server,
        dependentKeys: nil
      )),
      for: TestMutation.self
    )
    let response = try await apolloClient.perform(mutation: TestMutation(
      id: "1",
      updates: UpdatePersonMutationInput(name: "Brad")
    ))
    #expect(response.data == mockedResponseData)
    #expect(response.errors == nil)
  }

  @Test
  func subscribe_failsWithNoResultSetError() async throws {
    do {
      _ = try await apolloClient.subscribe(subscription: TestSubscription())
      Issue.record("Should fail.")
    } catch {
      guard case .noResultSet = error as? MockApolloClient.Error else {
        Issue.record(error, "Unexpected error.")
        return
      }
    }
  }

  @Test
  func subscribe_failsWithMockedError() async throws {
    struct TestError: Error { }
    await apolloClient.registerResult(
      .failure(TestError()),
      for: TestSubscription.self
    )
    do {
      _ = try await apolloClient.subscribe(subscription: TestSubscription())
      Issue.record("Should fail.")
    } catch {
      guard error is TestError else {
        Issue.record(error, "Unexpected error.")
        return
      }
    }
  }

  @Test
  func subscribe_succeedsWithMockedSuccessResponse() async throws {
    let mockedResponseData = TestSubscription.Data(people: .init(edges: [.init(node: .init(id: "1", name: "Brad"))]))
    await apolloClient.registerResult(
      .success(.init(
        data: mockedResponseData,
        extensions: nil,
        errors: nil,
        source: .server,
        dependentKeys: nil
      )),
      for: TestSubscription.self
    )
    let responseStream = try await apolloClient.subscribe(subscription: TestSubscription())
    for try await response in responseStream {
      #expect(response.data == mockedResponseData)
      #expect(response.errors == nil)
    }
  }

  // MARK: Private

  private var apolloClient: MockApolloClient! // swiftlint:disable:this implicitly_unwrapped_optional

}
