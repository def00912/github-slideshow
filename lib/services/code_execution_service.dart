import 'package:dio/dio.dart';
import '../models/code_execution_request.dart';
import '../models/code_execution_response.dart';

/// Service for executing code using cloud-based AI
class CodeExecutionService {
  final Dio _dio;
  
  // TODO: Replace with actual cloud API endpoint
  // For demo purposes, this could be Google Cloud Functions, AWS Lambda, or similar
  static const String _baseUrl = 'https://api.example.com/execute';
  
  CodeExecutionService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// Execute code and return the result
  Future<CodeExecutionResponse> executeCode(CodeExecutionRequest request) async {
    try {
      // For demonstration purposes, we'll simulate code execution
      // In production, this would make an actual API call to a cloud service
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulated response based on language
      final output = _simulateExecution(request.code, request.language);
      
      return CodeExecutionResponse.success(
        output,
        executionTime: 2000,
      );
      
      /* Production code would look like this:
      final response = await _dio.post(
        '/execute',
        data: request.toJson(),
      );
      
      return CodeExecutionResponse.fromJson(response.data);
      */
    } on DioException catch (e) {
      return CodeExecutionResponse.error(
        'Network error: ${e.message ?? 'Unknown error'}',
      );
    } catch (e) {
      return CodeExecutionResponse.error(
        'Execution error: ${e.toString()}',
      );
    }
  }

  /// Simulate code execution for demo purposes
  String _simulateExecution(String code, String language) {
    // Simple pattern matching for demo
    if (code.toLowerCase().contains('hello world') || 
        code.toLowerCase().contains('hello, world')) {
      return 'Hello, World!\n\nExecution completed successfully.';
    } else if (code.toLowerCase().contains('print') || 
               code.toLowerCase().contains('console.log') ||
               code.toLowerCase().contains('system.out.println')) {
      return 'Output:\nYour code was executed successfully!\n\n'
             'Note: This is a simulated execution.\n'
             'In production, this would connect to a real cloud-based AI interpreter.';
    } else if (code.trim().isEmpty) {
      return 'Error: No code provided.';
    } else {
      return 'Code analyzed successfully!\n\n'
             'Language: $language\n'
             'Lines of code: ${code.split('\n').length}\n\n'
             'Note: This is a demo implementation.\n'
             'Connect to Google Cloud AI Platform, AWS Lambda, or similar service for actual execution.';
    }
  }

  /// Validate code before execution
  bool validateCode(String code) {
    if (code.trim().isEmpty) {
      return false;
    }
    // Add more validation as needed
    return true;
  }
}
