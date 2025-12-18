/// Model class for code execution request
class CodeExecutionRequest {
  final String code;
  final String language;

  CodeExecutionRequest({
    required this.code,
    required this.language,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'language': language,
    };
  }
}
