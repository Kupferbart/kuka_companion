class StepModel {
  String title;
  String message;
  bool isCompleted;

  StepModel({
    required this.title,
    required this.message,
    this.isCompleted = false,
  });
}
