// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ApolloExtensions",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .tvOS(.v15),
    .watchOS(.v8),
    .visionOS(.v1),
  ],
  products: [
    .library(name: "ApolloExtensions", targets: ["ApolloExtensions"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", .upToNextMajor(from: "2.0.0")),
  ],
  targets: [
    .target(
      name: "ApolloExtensions",
      dependencies: [
        .product(name: "Apollo", package: "apollo-ios"),
      ]),
    .target(
      name: "ApolloExtensionsTestSchema",
      dependencies: [
        .product(name: "Apollo", package: "apollo-ios"),
      ],
      exclude: [
        "schema.graphqls",
      ]),
    .testTarget(
      name: "ApolloExtensionsTests",
      dependencies: [
        .target(name: "ApolloExtensions"),
        .target(name: "ApolloExtensionsTestSchema"),
      ],
      exclude: [
        "GraphQL/Person.graphql",
        "GraphQL/PersonCollection.graphql",
        "GraphQL/TestMutation.graphql",
        "GraphQL/TestQuery.graphql",
        "GraphQL/TestSubscription.graphql",
      ],
      resources: [
        .process("Resources"),
      ]),
  ],
  swiftLanguageModes: [.v6]
)
