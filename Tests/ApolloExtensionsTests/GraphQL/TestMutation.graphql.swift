// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI
import ApolloExtensionsTestSchema

struct TestMutation: GraphQLMutation {
  static let operationName: String = "TestMutation"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation TestMutation($id: ID!, $updates: UpdatePersonMutationInput!) { updatePerson(id: $id, updates: $updates) { __typename ...Person } }"#,
      fragments: [Person.self]
    ))

  public var id: ApolloExtensionsTestSchema.ID
  public var updates: ApolloExtensionsTestSchema.UpdatePersonMutationInput

  public init(
    id: ApolloExtensionsTestSchema.ID,
    updates: ApolloExtensionsTestSchema.UpdatePersonMutationInput
  ) {
    self.id = id
    self.updates = updates
  }

  @_spi(Unsafe) public var __variables: Variables? { [
    "id": id,
    "updates": updates
  ] }

  struct Data: ApolloExtensionsTestSchema.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: any ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.Mutation }
    static var __selections: [ApolloAPI.Selection] { [
      .field("updatePerson", UpdatePerson.self, arguments: [
        "id": .variable("id"),
        "updates": .variable("updates")
      ]),
    ] }
    static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      TestMutation.Data.self
    ] }

    var updatePerson: UpdatePerson { __data["updatePerson"] }

    init(
      updatePerson: UpdatePerson
    ) {
      self.init(unsafelyWithData: [
        "__typename": ApolloExtensionsTestSchema.Objects.Mutation.typename,
        "updatePerson": updatePerson._fieldData,
      ])
    }

    /// UpdatePerson
    ///
    /// Parent Type: `Person`
    struct UpdatePerson: ApolloExtensionsTestSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { ApolloExtensionsTestSchema.Objects.Person }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(Person.self),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        TestMutation.Data.UpdatePerson.self,
        Person.self
      ] }

      var id: ApolloExtensionsTestSchema.ID { __data["id"] }
      var name: String { __data["name"] }
      var nickname: String? { __data["nickname"] }
      var age: Int? { __data["age"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var person: Person { _toFragment() }
      }

      init(
        id: ApolloExtensionsTestSchema.ID,
        name: String,
        nickname: String? = nil,
        age: Int? = nil
      ) {
        self.init(unsafelyWithData: [
          "__typename": ApolloExtensionsTestSchema.Objects.Person.typename,
          "id": id,
          "name": name,
          "nickname": nickname,
          "age": age,
        ])
      }
    }
  }
}
