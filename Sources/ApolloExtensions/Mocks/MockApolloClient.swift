// Created by Brad Bergeron on 10/17/23.

#if DEBUG

@preconcurrency import Apollo
@preconcurrency import ApolloAPI
import Foundation

// MARK: - MockApolloClient

public final class MockApolloClient: ApolloClientProtocol {

  // MARK: Lifecycle

  public init(store: ApolloStore = .init()) {
    self.store = store
  }

  // MARK: Public

  public typealias ApolloClientResult = Result<any GraphQLResultProtocol, Swift.Error>

  public struct FetchParameters {
    public let cachePolicy: CachePolicy
    public let contextIdentifier: UUID?
    public let context: RequestContext?
    public let queue: DispatchQueue
  }

  public struct WatchParameters {
    public let cachePolicy: CachePolicy
    public let context: RequestContext?
    public let callbackQueue: DispatchQueue
  }

  public struct PerformParameters {
    public let publishResultToStore: Bool
    public let contextIdentifier: UUID?
    public let context: RequestContext?
    public let queue: DispatchQueue
  }

  public struct UploadParameters {
    public let files: [GraphQLFile]
    public let context: RequestContext?
    public let queue: DispatchQueue
  }

  public struct SubscribeParameters {
    public let context: RequestContext?
    public let queue: DispatchQueue
  }

  public let store: ApolloStore

  public var clearCacheResult: (DispatchQueue) -> Result<Void, Swift.Error> = { _ in .success(())}
  public var fetchResult: (FetchParameters) -> ApolloClientResult = { _ in .failure(Error.noResultSet) }
  public var watchResult: (WatchParameters) -> ApolloClientResult = { _ in .failure(Error.noResultSet) }
  public var performResult: (PerformParameters) -> ApolloClientResult = { _ in .failure(Error.noResultSet) }
  public var uploadResult: (UploadParameters) -> ApolloClientResult = { _ in .failure(Error.noResultSet) }
  public var subscribeResult: (SubscribeParameters) -> ApolloClientResult = { _ in .failure(Error.noResultSet) }

  public func clearCache(callbackQueue: DispatchQueue, completion: ((Result<Void, Swift.Error>) -> Void)?) {
    completion?(clearCacheResult(callbackQueue))
  }

  public func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy,
    contextIdentifier: UUID?,
    context: RequestContext?,
    queue: DispatchQueue,
    resultHandler: GraphQLResultHandler<Query.Data>?)
    -> Cancellable
  {
    let parameters = FetchParameters(
      cachePolicy: cachePolicy,
      contextIdentifier: contextIdentifier,
      context: context,
      queue: queue)
    let result = fetchResult(parameters)
    handleResult(result, forOperation: query, resultHandler: resultHandler)
    return EmptyCancellable()
  }

  public func watch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy,
    context: RequestContext?,
    callbackQueue: DispatchQueue,
    resultHandler: @escaping GraphQLResultHandler<Query.Data>)
    -> GraphQLQueryWatcher<Query>
  {
    let parameters = WatchParameters(
      cachePolicy: cachePolicy,
      context: context,
      callbackQueue: callbackQueue)
    let watcher = GraphQLQueryWatcher(
      client: self,
      query: query,
      context: context,
      callbackQueue: callbackQueue,
      resultHandler: resultHandler)
    let result = watchResult(parameters)
    handleResult(result, forOperation: query, resultHandler: resultHandler)
    return watcher
  }

  public func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    publishResultToStore: Bool,
    contextIdentifier: UUID?,
    context: RequestContext?,
    queue: DispatchQueue,
    resultHandler: GraphQLResultHandler<Mutation.Data>?)
    -> Cancellable
  {
    let parameters = PerformParameters(
      publishResultToStore: publishResultToStore,
      contextIdentifier: contextIdentifier,
      context: context,
      queue: queue)
    let result = performResult(parameters)
    handleResult(result, forOperation: mutation, resultHandler: resultHandler)
    return EmptyCancellable()
  }

  public func upload<Operation: GraphQLOperation>(
    operation: Operation,
    files: [GraphQLFile],
    context: RequestContext?,
    queue: DispatchQueue,
    resultHandler: GraphQLResultHandler<Operation.Data>?)
    -> Cancellable
  {
    let parameters = UploadParameters(
      files: files,
      context: context,
      queue: queue)
    let result = uploadResult(parameters)
    handleResult(result, forOperation: operation, resultHandler: resultHandler)
    return EmptyCancellable()
  }

  public func subscribe<Subscription: GraphQLSubscription>(
    subscription: Subscription,
    context: RequestContext?,
    queue: DispatchQueue,
    resultHandler: @escaping GraphQLResultHandler<Subscription.Data>)
    -> Cancellable
  {
    let parameters = SubscribeParameters(
      context: context,
      queue: queue)
    let result = subscribeResult(parameters)
    handleResult(result, forOperation: subscription, resultHandler: resultHandler)
    return EmptyCancellable()
  }

  // MARK: Internal

  enum Error: Swift.Error {
    case noResultSet
    case invalidResultTypeForOperation(any GraphQLOperation, any GraphQLResultProtocol)
  }

  // MARK: Private

  private func handleResult<Operation: GraphQLOperation>(
    _ result: ApolloClientResult,
    forOperation operation: Operation,
    resultHandler: GraphQLResultHandler<Operation.Data>?)
  {
    switch result {
    case .success(let someResult):
      guard let result = someResult as? GraphQLResult<Operation.Data> else {
        resultHandler?(.failure(Error.invalidResultTypeForOperation(operation, someResult)))
        return
      }
      resultHandler?(.success(result))
    case .failure(let error):
      resultHandler?(.failure(error))
    }
  }

}

#endif
