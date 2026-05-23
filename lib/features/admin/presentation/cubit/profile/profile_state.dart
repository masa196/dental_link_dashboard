class ProfileState {
  final bool isSubmitting;
  final String? focusedField;

  const ProfileState({this.isSubmitting = false, this.focusedField});

  ProfileState copyWith({bool? isSubmitting, String? focusedField}) {
    return ProfileState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      focusedField: focusedField ?? this.focusedField,
    );
  }
}
