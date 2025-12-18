import 'package:flutter/foundation.dart';
import '../models/code_execution_request.dart';
import '../models/code_execution_response.dart';
import '../models/programming_language.dart';
import '../services/code_execution_service.dart';

/// Provider for managing code execution state
class CodeExecutionProvider extends ChangeNotifier {
  final CodeExecutionService _executionService;

  CodeExecutionProvider(this._executionService);

  String _code = '';
  ProgrammingLanguage _selectedLanguage = ProgrammingLanguage.python;
  CodeExecutionResponse? _lastResponse;
  bool _isExecuting = false;
  String? _errorMessage;

  // Getters
  String get code => _code;
  ProgrammingLanguage get selectedLanguage => _selectedLanguage;
  CodeExecutionResponse? get lastResponse => _lastResponse;
  bool get isExecuting => _isExecuting;
  String? get errorMessage => _errorMessage;
  bool get hasOutput => _lastResponse != null;

  // Setters
  void setCode(String code) {
    _code = code;
    _errorMessage = null;
    notifyListeners();
  }

  void setLanguage(ProgrammingLanguage language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  /// Execute the current code
  Future<void> executeCode() async {
    if (_code.trim().isEmpty) {
      _errorMessage = 'Please enter some code to execute';
      notifyListeners();
      return;
    }

    _isExecuting = true;
    _errorMessage = null;
    _lastResponse = null;
    notifyListeners();

    try {
      final request = CodeExecutionRequest(
        code: _code,
        language: _selectedLanguage.displayName,
      );

      final response = await _executionService.executeCode(request);
      _lastResponse = response;

      if (!response.success && response.error != null) {
        _errorMessage = response.error;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: ${e.toString()}';
    } finally {
      _isExecuting = false;
      notifyListeners();
    }
  }

  /// Clear the output
  void clearOutput() {
    _lastResponse = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear all state
  void reset() {
    _code = '';
    _selectedLanguage = ProgrammingLanguage.python;
    _lastResponse = null;
    _isExecuting = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Load sample code for the selected language
  void loadSampleCode() {
    _code = _getSampleCode(_selectedLanguage);
    _errorMessage = null;
    _lastResponse = null;
    notifyListeners();
  }

  /// Get sample code for a given language
  String _getSampleCode(ProgrammingLanguage language) {
    switch (language) {
      case ProgrammingLanguage.python:
        return '''# Python Hello World
print("Hello, World!")

# Calculate factorial
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

print(f"Factorial of 5 is: {factorial(5)}")''';

      case ProgrammingLanguage.javascript:
        return '''// JavaScript Hello World
console.log("Hello, World!");

// Calculate factorial
function factorial(n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

console.log(\`Factorial of 5 is: \${factorial(5)}\`);''';

      case ProgrammingLanguage.java:
        return '''// Java Hello World
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        
        // Calculate factorial
        System.out.println("Factorial of 5 is: " + factorial(5));
    }
    
    static int factorial(int n) {
        if (n <= 1) return 1;
        return n * factorial(n - 1);
    }
}''';

      case ProgrammingLanguage.cpp:
        return '''// C++ Hello World
#include <iostream>
using namespace std;

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    cout << "Hello, World!" << endl;
    cout << "Factorial of 5 is: " << factorial(5) << endl;
    return 0;
}''';

      case ProgrammingLanguage.go:
        return '''// Go Hello World
package main

import "fmt"

func factorial(n int) int {
    if n <= 1 {
        return 1
    }
    return n * factorial(n-1)
}

func main() {
    fmt.Println("Hello, World!")
    fmt.Printf("Factorial of 5 is: %d\\n", factorial(5))
}''';

      case ProgrammingLanguage.rust:
        return '''// Rust Hello World
fn factorial(n: u32) -> u32 {
    if n <= 1 {
        1
    } else {
        n * factorial(n - 1)
    }
}

fn main() {
    println!("Hello, World!");
    println!("Factorial of 5 is: {}", factorial(5));
}''';

      case ProgrammingLanguage.typescript:
        return '''// TypeScript Hello World
function factorial(n: number): number {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

console.log("Hello, World!");
console.log(\`Factorial of 5 is: \${factorial(5)}\`);''';

      case ProgrammingLanguage.php:
        return '''<?php
// PHP Hello World
echo "Hello, World!\\n";

// Calculate factorial
function factorial($n) {
    if ($n <= 1) return 1;
    return $n * factorial($n - 1);
}

echo "Factorial of 5 is: " . factorial(5) . "\\n";
?>''';

      case ProgrammingLanguage.ruby:
        return '''# Ruby Hello World
puts "Hello, World!"

# Calculate factorial
def factorial(n)
    return 1 if n <= 1
    n * factorial(n - 1)
end

puts "Factorial of 5 is: #{factorial(5)}"''';

      case ProgrammingLanguage.swift:
        return '''// Swift Hello World
func factorial(_ n: Int) -> Int {
    if n <= 1 {
        return 1
    }
    return n * factorial(n - 1)
}

print("Hello, World!")
print("Factorial of 5 is: \\(factorial(5))")''';

      case ProgrammingLanguage.kotlin:
        return '''// Kotlin Hello World
fun factorial(n: Int): Int {
    return if (n <= 1) 1 else n * factorial(n - 1)
}

fun main() {
    println("Hello, World!")
    println("Factorial of 5 is: \${factorial(5)}")
}''';
    }
  }
}
