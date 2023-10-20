// Created by Brad Bergeron on 10/19/23.

import Apollo

extension GraphQLResult {
  public init(
    data: Data,
    errors: [GraphQLError] = [],
    source: Source = .server,
    extensions: [String: AnyHashable]? = nil,
    dependentKeys: Set<CacheKey>? = nil)
  {
    self.init(
      data: data,
      extensions: extensions,
      errors: errors,
      source: source,
      dependentKeys: dependentKeys)
  }
}
