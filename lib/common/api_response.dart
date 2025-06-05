class ApiResponse {
  final String statusCode;
  final String message;
  final List<dynamic> data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode']?.toString() ?? '',
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
