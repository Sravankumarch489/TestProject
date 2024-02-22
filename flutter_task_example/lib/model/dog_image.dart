class RandomDog {
  late String message;
   late String status;

  RandomDog({required this.message, required this.status});

  factory RandomDog.fromJson(Map<String, dynamic> json) {
    return RandomDog(
      message: json['message'],
      status: json['status'],
    );
  }
}
