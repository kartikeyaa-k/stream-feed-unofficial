import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';

part 'user_model.g.dart';

/// `UserModel` represents the data model for a user, typically used within the data layer of the application.
/// This class is responsible for serializing and deserializing user data to and from JSON format,
/// as well as converting itself into a `UserEntity` for use in the domain layer.
///
/// It extends `Equatable` to facilitate comparison, ensuring that user objects can be efficiently compared
/// based on their properties, which is essential for state management and business logic.
@JsonSerializable()
class UserModel extends Equatable {
  /// Creates a new instance of [UserModel].
  ///
  /// - [id]: The unique identifier of the user.
  /// - [data]: A map containing additional user data, such as name, occupation, gender, and profile image.
  /// - [createdAt]: The date and time when the user was created.
  /// - [updatedAt]: The date and time when the user was last updated.
  /// - [followersCount]: The count of users following this user.
  /// - [followingCount]: The count of users that this user is following.
  const UserModel({
    this.id,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.followersCount,
    this.followingCount,
  });

  /// Factory constructor for creating a new `UserModel` instance from a JSON map.
  ///
  /// - [json]: A map representing the user data in JSON format.
  /// - Returns: A `UserModel` object populated with data from the JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// The unique identifier of the user.
  final String? id;

  /// A map containing additional user data, which can include fields such as name, occupation, gender, and profile image.
  final Map<String, Object?>? data;

  /// The date and time when the user was created.
  final DateTime? createdAt;

  /// The date and time when the user was last updated.
  final DateTime? updatedAt;

  /// The count of users following this user.
  final int? followersCount;

  /// The count of users that this user is following.
  final int? followingCount;

  /// Properties used for equality comparison, allowing `UserModel` instances to be compared based on their values.
  @override
  List<Object?> get props => [
        id,
        data,
        createdAt,
        updatedAt,
        followersCount,
        followingCount,
      ];

  /// Converts the `UserModel` to a JSON map, suitable for serialization and storage.
  ///
  /// - Returns: A map representing the user data in JSON format.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Converts the `UserModel` into a `UserEntity`, which is used within the domain layer.
  ///
  /// This conversion allows the `UserModel` to be used in business logic, ensuring that only necessary
  /// and relevant data is exposed beyond the data layer.
  ///
  /// - Returns: A `UserEntity` object containing the converted user data.
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: data?['name'] as String? ?? '',
      occupation: data?['occupation'] as String? ?? '',
      gender: data?['gender'] as String? ?? '',
      profileImage: data?['profileImage'] as String? ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      followersCount: followersCount,
      followingCount: followingCount,
    );
  }
}
