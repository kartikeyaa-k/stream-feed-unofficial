import 'package:equatable/equatable.dart';

/// `UserEntity` represents a user in the domain layer of the application.
/// This class encapsulates the user's personal and profile information, along with
/// metadata such as the number of followers and following counts.
///
/// `UserEntity` is used throughout the application where user information is
/// required, ensuring a consistent and structured approach to handling user data.
class UserEntity extends Equatable {
  /// Unique identifier of the user.
  final String? id;

  /// The name of the user.
  final String? name;

  /// The occupation of the user, such as job title or role.
  final String? occupation;

  /// The gender of the user (e.g., male, female, non-binary).
  final String? gender;

  /// URL of the user's profile image.
  final String? profileImage;

  /// The date and time when the user profile was created.
  final DateTime? createdAt;

  /// The date and time when the user profile was last updated.
  final DateTime? updatedAt;

  /// The number of followers the user has.
  final int? followersCount;

  /// The number of other users that this user is following.
  final int? followingCount;

  /// Constructs a `UserEntity` with the specified details.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the user.
  /// - [name]: The name of the user.
  /// - [occupation]: The occupation of the user.
  /// - [gender]: The gender of the user.
  /// - [profileImage]: The URL to the user's profile image.
  /// - [createdAt]: The date and time when the user profile was created.
  /// - [updatedAt]: The date and time when the user profile was last updated.
  /// - [followersCount]: The number of followers the user has.
  /// - [followingCount]: The number of users this user is following.
  const UserEntity({
    this.id,
    this.name,
    this.occupation,
    this.gender,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.followersCount,
    this.followingCount,
  });

  /// Properties used to determine equality between instances of `UserEntity`.
  ///
  /// This method is used by the `equatable` package to compare instances of
  /// `UserEntity` by checking if all properties are equal, allowing for
  /// value-based comparison rather than reference-based.
  @override
  List<Object?> get props => [
        id,
        name,
        occupation,
        gender,
        profileImage,
        createdAt,
        updatedAt,
        followersCount,
        followingCount,
      ];
}
