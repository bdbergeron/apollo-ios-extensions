// Created by Brad Bergeron on 10/31/25.

#if DEBUG

@_spi(Internal) @_spi(Execution) public import Apollo
public import Foundation

@_spi(Unsafe) import ApolloAPI

extension GraphQLOperation {
  public func mockedJSONResponse(url: URL) async throws -> GraphQLResponse<Self> {
    let (data, _) = try await URLSession.shared.data(from: url)
    let body = try JSONSerializationFormat.deserialize(data: data) as JSONObject
    return try await JSONResponseParser
      .SingleResponseExecutionHandler(responseBody: body, operationVariables: __variables)
      .execute(includeCacheRecords: false)
      .result
  }
}

#endif
