// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UpdatePersonMutationInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    name: String,
    nickname: GraphQLNullable<String> = nil,
    age: GraphQLNullable<Int> = nil
  ) {
    __data = InputDict([
      "name": name,
      "nickname": nickname,
      "age": age
    ])
  }

  public var name: String {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var nickname: GraphQLNullable<String> {
    get { __data["nickname"] }
    set { __data["nickname"] = newValue }
  }

  public var age: GraphQLNullable<Int> {
    get { __data["age"] }
    set { __data["age"] = newValue }
  }
}
