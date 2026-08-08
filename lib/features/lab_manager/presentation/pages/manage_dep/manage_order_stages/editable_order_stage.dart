class EditableOrderStage {
  EditableOrderStage({
    required this.departmentId,
    required this.departmentName,
    required this.hours,
  });

  int departmentId;
  String departmentName;
  int hours;


  EditableOrderStage copy() {
    return EditableOrderStage(
      departmentId: departmentId,
      departmentName: departmentName,
      hours: hours,
    );
  }
}