// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import ApolloExtensionsTestSchema

struct Person: ApolloExtensionsTestSchema.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment Person on Person { __typename id name nickname age }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: any ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.Person }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", ApolloExtensionsTestSchema.ID.self),
    .field("name", String.self),
    .field("nickname", String?.self),
    .field("age", Int?.self),
  ] }

  var id: ApolloExtensionsTestSchema.ID { __data["id"] }
  var name: String { __data["name"] }
  var nickname: String? { __data["nickname"] }
  var age: Int? { __data["age"] }

  init(
    id: ApolloExtensionsTestSchema.ID,
    name: String,
    nickname: String? = nil,
    age: Int? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": ApolloExtensionsTestSchema.Objects.Person.typename,
        "id": id,
        "name": name,
        "nickname": nickname,
        "age": age,
      ],
      fulfilledFragments: [
        ObjectIdentifier(Person.self)
      ]
    ))
  }
}
