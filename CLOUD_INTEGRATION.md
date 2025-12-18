# Cloud API Integration Guide

This document provides detailed instructions for integrating cloud-based AI services with the Flutter Code Interpreter app.

## Overview

The app is designed to work with cloud-based AI code interpretation services. The current implementation includes a simulated execution service that can be easily replaced with real cloud API calls.

## Supported Cloud Platforms

### 1. Google Cloud AI Platform

**Setup Steps:**

1. Create a Google Cloud Project
2. Enable the necessary APIs:
   - Cloud Functions API
   - Cloud AI Platform API
3. Create a Cloud Function to execute code
4. Set up authentication

**Example Cloud Function (Python):**

```python
import functions_framework
import json

@functions_framework.http
def execute_code(request):
    request_json = request.get_json()
    code = request_json.get('code')
    language = request_json.get('language')
    
    # Add your code execution logic here
    # Use appropriate sandboxing and security measures
    
    return json.dumps({
        'success': True,
        'output': 'Execution result',
        'executionTime': 1000
    })
```

**Integration in Flutter:**

```dart
// In lib/services/code_execution_service.dart
static const String _baseUrl = 'https://YOUR-REGION-YOUR-PROJECT.cloudfunctions.net';

CodeExecutionService() : _dio = Dio() {
  _dio.options.baseUrl = _baseUrl;
  _dio.options.headers['Content-Type'] = 'application/json';
}

Future<CodeExecutionResponse> executeCode(CodeExecutionRequest request) async {
  final response = await _dio.post(
    '/execute_code',
    data: request.toJson(),
  );
  return CodeExecutionResponse.fromJson(response.data);
}
```

### 2. AWS Lambda with API Gateway

**Setup Steps:**

1. Create an AWS account
2. Set up Lambda function for code execution
3. Configure API Gateway
4. Set up IAM roles and permissions

**Example Lambda Function (Node.js):**

```javascript
exports.handler = async (event) => {
    const { code, language } = JSON.parse(event.body);
    
    // Add code execution logic here
    // Consider using AWS Lambda Layers for language runtimes
    
    return {
        statusCode: 200,
        body: JSON.stringify({
            success: true,
            output: 'Execution result',
            executionTime: 1000
        })
    };
};
```

**Integration in Flutter:**

```dart
static const String _baseUrl = 'https://YOUR-API-ID.execute-api.REGION.amazonaws.com/prod';

// Add API key if using API Gateway with key authentication
CodeExecutionService() : _dio = Dio() {
  _dio.options.baseUrl = _baseUrl;
  _dio.options.headers['x-api-key'] = 'YOUR_API_KEY';
}
```

### 3. Azure Functions

**Setup Steps:**

1. Create an Azure account
2. Create a Function App
3. Deploy HTTP-triggered function
4. Configure CORS and authentication

**Example Azure Function (C#):**

```csharp
[FunctionName("ExecuteCode")]
public static async Task<IActionResult> Run(
    [HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequest req,
    ILogger log)
{
    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic data = JsonConvert.DeserializeObject(requestBody);
    
    // Add code execution logic here
    
    return new OkObjectResult(new {
        success = true,
        output = "Execution result",
        executionTime = 1000
    });
}
```

### 4. Custom Backend Server

If you prefer to host your own backend:

**Requirements:**
- Secure code execution environment (Docker containers recommended)
- Rate limiting
- Authentication/Authorization
- Input validation and sanitization

**Example using FastAPI (Python):**

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import subprocess
import tempfile
import os

app = FastAPI()

class CodeRequest(BaseModel):
    code: str
    language: str

@app.post("/execute")
async def execute_code(request: CodeRequest):
    try:
        # Create temporary file
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.py') as f:
            f.write(request.code)
            temp_file = f.name
        
        # Execute in sandbox (use Docker or similar for production)
        result = subprocess.run(
            ['python3', temp_file],
            capture_output=True,
            text=True,
            timeout=10
        )
        
        # Clean up
        os.unlink(temp_file)
        
        return {
            'success': True,
            'output': result.stdout or result.stderr,
            'executionTime': 0
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

## Security Considerations

### Critical Security Measures:

1. **Sandboxing**: Always execute user code in isolated environments
   - Use Docker containers
   - Implement resource limits (CPU, memory, time)
   - Network isolation

2. **Input Validation**:
   - Validate code length
   - Check for malicious patterns
   - Sanitize all inputs

3. **Rate Limiting**:
   - Implement per-user rate limits
   - Set execution time limits
   - Monitor API usage

4. **Authentication**:
   - Use API keys or OAuth 2.0
   - Implement token rotation
   - Monitor for suspicious activity

5. **Code Execution Limits**:
   ```dart
   // In code_execution_service.dart
   static const int MAX_CODE_LENGTH = 10000;
   static const int MAX_EXECUTION_TIME = 30; // seconds
   
   bool validateCode(String code) {
     if (code.trim().isEmpty || code.length > MAX_CODE_LENGTH) {
       return false;
     }
     // Add more validation
     return true;
   }
   ```

## Environment Variables

Store sensitive configuration in environment variables:

```dart
// Create a config.dart file (add to .gitignore)
class Config {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );
  
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );
}
```

Run with environment variables:
```bash
flutter run --dart-define=API_BASE_URL=https://your-api.com --dart-define=API_KEY=your_key
```

## Error Handling

Implement comprehensive error handling:

```dart
Future<CodeExecutionResponse> executeCode(CodeExecutionRequest request) async {
  try {
    final response = await _dio.post(
      '/execute',
      data: request.toJson(),
    );
    return CodeExecutionResponse.fromJson(response.data);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return CodeExecutionResponse.error('Connection timeout');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return CodeExecutionResponse.error('Execution timeout');
    } else if (e.response?.statusCode == 429) {
      return CodeExecutionResponse.error('Rate limit exceeded');
    } else {
      return CodeExecutionResponse.error('Network error: ${e.message}');
    }
  } catch (e) {
    return CodeExecutionResponse.error('Unexpected error: $e');
  }
}
```

## Testing Cloud Integration

1. **Local Testing**: Use mock server or Postman
2. **Staging Environment**: Test with limited access
3. **Production**: Gradual rollout with monitoring

## Monitoring and Analytics

Implement logging and monitoring:

```dart
// Add logging interceptor
_dio.interceptors.add(LogInterceptor(
  requestBody: true,
  responseBody: true,
  error: true,
));

// Add analytics tracking
Future<CodeExecutionResponse> executeCode(CodeExecutionRequest request) async {
  final startTime = DateTime.now();
  
  try {
    final response = await _dio.post('/execute', data: request.toJson());
    
    // Log success metrics
    _logAnalytics('code_execution_success', {
      'language': request.language,
      'duration': DateTime.now().difference(startTime).inMilliseconds,
    });
    
    return CodeExecutionResponse.fromJson(response.data);
  } catch (e) {
    // Log error metrics
    _logAnalytics('code_execution_error', {
      'language': request.language,
      'error': e.toString(),
    });
    rethrow;
  }
}
```

## Cost Optimization

1. **Caching**: Cache frequently executed code snippets
2. **Connection Pooling**: Reuse HTTP connections
3. **Compression**: Enable gzip compression
4. **Batch Processing**: Process multiple requests together when possible

## Next Steps

1. Choose your cloud platform
2. Set up the backend service
3. Update `code_execution_service.dart` with your API endpoint
4. Add authentication credentials
5. Test thoroughly with various code samples
6. Monitor performance and costs
7. Implement rate limiting and security measures

## Support and Resources

- [Google Cloud Functions Documentation](https://cloud.google.com/functions/docs)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [Azure Functions Documentation](https://docs.microsoft.com/en-us/azure/azure-functions/)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Flutter Provider](https://pub.dev/packages/provider)

---

**Important**: Never commit API keys or sensitive credentials to version control. Always use environment variables or secure secret management services.
