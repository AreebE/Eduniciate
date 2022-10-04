enum UserRole {
  student,
  owner;

  static UserRole getRole(String name) {
    switch (name) {
      case "owner":
        return UserRole.owner;
      case "student":
      default:
        return UserRole.student;
    }
  }
}
