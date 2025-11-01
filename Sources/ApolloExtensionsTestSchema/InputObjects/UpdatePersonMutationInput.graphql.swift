// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

public struct UpdatePersonMutationInput: InputObject {
  @_spi(Unsafe) public private(set) var __data: InputDict

  @_spi(Unsafe) public init(_ data: InputDict) {
    __data = data
  }

  public init(
    name: String,
    nickname: GraphQLNullable<String> = nil,
    age: GraphQLNullable<Int32> = nil
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

  public var age: GraphQLNullable<Int32> {
    get { __data["age"] }
    set { __data["age"] = newValue }
  }
}
