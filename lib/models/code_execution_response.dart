/// Model class for code execution response
class CodeExecutionResponse {
  final String output;
  final String? error;
  final bool success;
  final int? executionTime;

  CodeExecutionResponse({
    required this.output,
    this.error,
    required this.success,
    this.executionTime,
  });

  factory CodeExecutionResponse.fromJson(Map<String, dynamic> json) {
    return CodeExecutionResponse(
      output: json['output'] ?? '',
      error: json['error'],
      success: json['success'] ?? false,
      executionTime: json['executionTime'],
    );
  }

  factory CodeExecutionResponse.error(String errorMessage) {
    return CodeExecutionResponse(
      output: '',
      error: errorMessage,
      success: false,
    );
  }

  factory CodeExecutionResponse.success(String output, {int? executionTime}) {
    return CodeExecutionResponse(
      output: output,
      success: true,
      executionTime: executionTime,
    );
  }
}
