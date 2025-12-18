import 'package:flutter_test/flutter_test.dart';
import 'package:code_interpreter_app/models/programming_language.dart';
import 'package:code_interpreter_app/models/code_execution_request.dart';
import 'package:code_interpreter_app/models/code_execution_response.dart';
import 'package:code_interpreter_app/services/code_execution_service.dart';

void main() {
  group('ProgrammingLanguage', () {
    test('should have 11 languages', () {
      expect(ProgrammingLanguage.values.length, 11);
    });

    test('should convert from display name', () {
      final lang = ProgrammingLanguage.fromDisplayName('Python');
      expect(lang, ProgrammingLanguage.python);
    });

    test('should default to Python for unknown language', () {
      final lang = ProgrammingLanguage.fromDisplayName('UnknownLang');
      expect(lang, ProgrammingLanguage.python);
    });
  });

  group('CodeExecutionRequest', () {
    test('should convert to JSON', () {
      final request = CodeExecutionRequest(
        code: 'print("Hello")',
        language: 'Python',
      );

      final json = request.toJson();
      expect(json['code'], 'print("Hello")');
      expect(json['language'], 'Python');
    });
  });

  group('CodeExecutionResponse', () {
    test('should create success response', () {
      final response = CodeExecutionResponse.success(
        'Hello, World!',
        executionTime: 100,
      );

      expect(response.success, true);
      expect(response.output, 'Hello, World!');
      expect(response.executionTime, 100);
      expect(response.error, null);
    });

    test('should create error response', () {
      final response = CodeExecutionResponse.error('Syntax error');

      expect(response.success, false);
      expect(response.error, 'Syntax error');
      expect(response.output, '');
    });

    test('should parse from JSON', () {
      final json = {
        'output': 'Test output',
        'success': true,
        'executionTime': 200,
      };

      final response = CodeExecutionResponse.fromJson(json);
      expect(response.output, 'Test output');
      expect(response.success, true);
      expect(response.executionTime, 200);
    });
  });

  group('CodeExecutionService', () {
    late CodeExecutionService service;

    setUp(() {
      service = CodeExecutionService();
    });

    test('should validate non-empty code', () {
      expect(service.validateCode('print("hello")'), true);
    });

    test('should not validate empty code', () {
      expect(service.validateCode(''), false);
      expect(service.validateCode('   '), false);
    });

    test('should execute code and return response', () async {
      final request = CodeExecutionRequest(
        code: 'print("Hello, World!")',
        language: 'Python',
      );

      final response = await service.executeCode(request);
      expect(response.success, true);
      expect(response.output, isNotEmpty);
    });

    test('should handle empty code execution', () async {
      final request = CodeExecutionRequest(
        code: '',
        language: 'Python',
      );

      final response = await service.executeCode(request);
      expect(response.output, contains('Error'));
    });
  });
}
