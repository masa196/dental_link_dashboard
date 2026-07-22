enum MaterialsMode {
  manager,
  receptionist;

  bool get canEdit {
    switch (this) {
      case MaterialsMode.manager:
        return true;

      case MaterialsMode.receptionist:
        return false;
    }
  }
}