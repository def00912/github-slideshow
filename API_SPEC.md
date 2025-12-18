# API Specification for Code Execution Service

This document describes the API contract between the Flutter mobile app and the backend code execution service.

## Overview

The Code Execution Service API provides a RESTful interface for executing code in various programming languages using cloud-based AI interpretation.

## Base URL

```
https://api.example.com/v1
```

Replace with your actual API endpoint.

## Authentication

Use API Key authentication:

```
Authorization: Bearer YOUR_API_KEY
```

Or use header-based authentication:

```
X-API-Key: YOUR_API_KEY
```

## Endpoints

### 1. Execute Code

Executes code in the specified programming language.

**Endpoint:** `POST /execute`

**Request Headers:**
```
Content-Type: application/json
Authorization: Bearer YOUR_API_KEY
```

**Request Body:**

```json
{
  "code": "print('Hello, World!')",
  "language": "Python"
}
```

**Request Schema:**

| Field    | Type   | Required | Description                              |
|----------|--------|----------|------------------------------------------|
| code     | string | Yes      | The source code to execute               |
| language | string | Yes      | Programming language (Python, JavaScript, etc.) |

**Supported Languages:**
- Python
- JavaScript
- Java
- C++
- Go
- Rust
- TypeScript
- PHP
- Ruby
- Swift
- Kotlin

**Success Response:**

**Status Code:** `200 OK`

```json
{
  "success": true,
  "output": "Hello, World!\n",
  "error": null,
  "executionTime": 1250
}
```

**Response Schema:**

| Field         | Type    | Description                                    |
|---------------|---------|------------------------------------------------|
| success       | boolean | Whether the execution was successful           |
| output        | string  | The output/result of the code execution        |
| error         | string  | Error message if execution failed (nullable)   |
| executionTime | integer | Execution time in milliseconds (nullable)      |

**Error Responses:**

**Status Code:** `400 Bad Request`

```json
{
  "success": false,
  "output": "",
  "error": "Invalid programming language specified",
  "executionTime": null
}
```

**Status Code:** `408 Request Timeout`

```json
{
  "success": false,
  "output": "",
  "error": "Code execution timeout (exceeded 30 seconds)",
  "executionTime": 30000
}
```

**Status Code:** `413 Payload Too Large`

```json
{
  "success": false,
  "output": "",
  "error": "Code exceeds maximum length of 10000 characters",
  "executionTime": null
}
```

**Status Code:** `429 Too Many Requests`

```json
{
  "success": false,
  "output": "",
  "error": "Rate limit exceeded. Please try again later.",
  "executionTime": null
}
```

**Status Code:** `500 Internal Server Error`

```json
{
  "success": false,
  "output": "",
  "error": "Internal server error during code execution",
  "executionTime": null
}
```

## Request Validation

### Code Validation Rules:

1. **Length**: Maximum 10,000 characters
2. **Required**: Cannot be empty or null
3. **Content**: Should be valid text (UTF-8 encoded)

### Language Validation Rules:

1. **Required**: Cannot be empty or null
2. **Allowed Values**: Must be one of the supported languages
3. **Case Sensitive**: "Python" is valid, "python" may be invalid (depending on implementation)

## Rate Limiting

**Limits:**
- 100 requests per minute per API key
- 1,000 requests per hour per API key

**Response Headers:**
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640000000
```

When rate limit is exceeded, the API returns status code `429` with:

```json
{
  "success": false,
  "error": "Rate limit exceeded",
  "retryAfter": 60
}
```

## Security Considerations

### Code Execution Sandbox

All code must be executed in a secure sandbox environment with:

1. **Resource Limits:**
   - Maximum CPU time: 30 seconds
   - Maximum memory: 512 MB
   - No network access
   - No file system write access (except temp)

2. **Isolation:**
   - Containerized execution (Docker recommended)
   - No access to host system
   - No access to other users' code or data

3. **Input Sanitization:**
   - Remove potentially harmful code patterns
   - Validate all inputs
   - Escape special characters

### Best Practices:

1. Use HTTPS only (TLS 1.2 or higher)
2. Implement API key rotation
3. Log all requests for audit purposes
4. Monitor for suspicious patterns
5. Implement IP-based rate limiting
6. Use Web Application Firewall (WAF)

## Example Requests

### Python Example

```bash
curl -X POST https://api.example.com/v1/execute \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "code": "def greet(name):\n    return f\"Hello, {name}!\"\n\nprint(greet(\"World\"))",
    "language": "Python"
  }'
```

**Response:**
```json
{
  "success": true,
  "output": "Hello, World!\n",
  "error": null,
  "executionTime": 1050
}
```

### JavaScript Example

```bash
curl -X POST https://api.example.com/v1/execute \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "code": "const greet = (name) => `Hello, ${name}!`;\nconsole.log(greet(\"World\"));",
    "language": "JavaScript"
  }'
```

**Response:**
```json
{
  "success": true,
  "output": "Hello, World!\n",
  "error": null,
  "executionTime": 890
}
```

### Error Example (Syntax Error)

```bash
curl -X POST https://api.example.com/v1/execute \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "code": "print(\"Missing closing quote)",
    "language": "Python"
  }'
```

**Response:**
```json
{
  "success": false,
  "output": "",
  "error": "SyntaxError: EOL while scanning string literal",
  "executionTime": 50
}
```

## Client Implementation (Flutter)

### Dart/Flutter Example

```dart
import 'package:dio/dio.dart';

class CodeExecutionService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.example.com/v1';
  static const String _apiKey = 'YOUR_API_KEY';

  CodeExecutionService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer $_apiKey';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<CodeExecutionResponse> executeCode(CodeExecutionRequest request) async {
    try {
      final response = await _dio.post(
        '/execute',
        data: request.toJson(),
      );
      return CodeExecutionResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return CodeExecutionResponse.error('Rate limit exceeded');
      }
      return CodeExecutionResponse.error('Network error: ${e.message}');
    }
  }
}
```

## Monitoring and Analytics

### Recommended Metrics to Track:

1. **Request Metrics:**
   - Total requests per minute/hour/day
   - Requests by language
   - Average execution time by language
   - Success rate

2. **Error Metrics:**
   - Error rate by type
   - Timeout frequency
   - Rate limit hits

3. **Performance Metrics:**
   - P50, P95, P99 response times
   - Queue depth
   - Resource utilization

## Webhooks (Optional)

For long-running code execution, consider implementing webhooks:

**Request:**
```json
{
  "code": "...",
  "language": "Python",
  "webhook": "https://your-app.com/callback"
}
```

**Immediate Response:**
```json
{
  "executionId": "abc123",
  "status": "queued"
}
```

**Callback (POST to webhook URL):**
```json
{
  "executionId": "abc123",
  "success": true,
  "output": "...",
  "executionTime": 5000
}
```

## Versioning

API versioning is done via URL path:
- Current version: `/v1/`
- Future versions: `/v2/`, etc.

Breaking changes will require a new version.

## Support

For API support:
- Email: api-support@example.com
- Documentation: https://docs.example.com
- Status Page: https://status.example.com

---

**Last Updated:** December 2024
**API Version:** 1.0.0
