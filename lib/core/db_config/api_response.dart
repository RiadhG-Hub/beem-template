class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResponse({required this.success, this.data, this.error});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      success: json['Status'] == "1",
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['ErrorMessage'],
    );
  }
}
