// Created by Brad Bergeron on 10/19/23.

#if DEBUG

import Apollo
import ApolloAPI
import Foundation

extension GraphQLResult {
  public static func mockedJSONResponse<Operation: GraphQLOperation>(
    for operation: Operation,
    jsonURL url: URL)
    throws
    -> GraphQLResult
    where
    Data == Operation.Data
  {
    let data = try Foundation.Data(contentsOf: url)
    guard let body = try? JSONSerializationFormat.deserialize(data: data) as? JSONObject else {
      throw JSONResponseParsingInterceptor.JSONResponseParsingError.couldNotParseToJSON(data: data)
    }
    let response = GraphQLResponse(operation: operation, body: body)
    return try response.parseResultFast()
  }
}

#endif
