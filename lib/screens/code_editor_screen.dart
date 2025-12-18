import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/code_execution_provider.dart';
import '../models/programming_language.dart';

/// Main screen for code input and execution
class CodeEditorScreen extends StatelessWidget {
  const CodeEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Code Interpreter'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: 'About',
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LanguageSelector(),
                SizedBox(height: 16),
                _CodeInputArea(),
                SizedBox(height: 16),
                _ActionButtons(),
                SizedBox(height: 16),
                _OutputArea(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Code Interpreter'),
        content: const Text(
          'This app demonstrates a cloud-based AI code interpreter.\n\n'
          'Features:\n'
          '• Support for 11 programming languages\n'
          '• Real-time code execution simulation\n'
          '• Sample code snippets\n'
          '• Error handling\n\n'
          'Note: This is a demo version. Connect to Google Cloud AI Platform, '
          'AWS Lambda, or similar service for actual code execution.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Language selector dropdown
class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) {
    return Consumer<CodeExecutionProvider>(
      builder: (context, provider, _) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(Icons.code, color: Colors.blue),
                const SizedBox(width: 12),
                const Text(
                  'Language:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<ProgrammingLanguage>(
                    value: provider.selectedLanguage,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: ProgrammingLanguage.values.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang.displayName),
                      );
                    }).toList(),
                    onChanged: (lang) {
                      if (lang != null) {
                        provider.setLanguage(lang);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Code input text area
class _CodeInputArea extends StatefulWidget {
  const _CodeInputArea();

  @override
  State<_CodeInputArea> createState() => _CodeInputAreaState();
}

class _CodeInputAreaState extends State<_CodeInputArea> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CodeExecutionProvider>(
      builder: (context, provider, _) {
        // Update controller when sample code is loaded
        if (provider.code != _controller.text) {
          _controller.text = provider.code;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        }

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.edit_note, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Code Editor',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    if (_controller.text.isNotEmpty)
                      TextButton.icon(
                        onPressed: () {
                          _controller.clear();
                          provider.setCode('');
                        },
                        icon: const Icon(Icons.clear, size: 16),
                        label: const Text('Clear'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _controller,
                  maxLines: 15,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your code here...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                  onChanged: (value) => provider.setCode(value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Action buttons for execution and sample loading
class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Consumer<CodeExecutionProvider>(
      builder: (context, provider, _) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: provider.isExecuting
                    ? null
                    : () => provider.executeCode(),
                icon: provider.isExecuting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(
                  provider.isExecuting ? 'Executing...' : 'Execute Code',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: provider.isExecuting
                    ? null
                    : () => provider.loadSampleCode(),
                icon: const Icon(Icons.code_outlined),
                label: const Text('Load Sample'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Output display area
class _OutputArea extends StatelessWidget {
  const _OutputArea();

  @override
  Widget build(BuildContext context) {
    return Consumer<CodeExecutionProvider>(
      builder: (context, provider, _) {
        if (!provider.hasOutput && provider.errorMessage == null) {
          return const SizedBox.shrink();
        }

        return Card(
          elevation: 2,
          color: provider.errorMessage != null
              ? Colors.red.shade50
              : Colors.green.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      provider.errorMessage != null
                          ? Icons.error_outline
                          : Icons.check_circle_outline,
                      size: 20,
                      color: provider.errorMessage != null
                          ? Colors.red
                          : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      provider.errorMessage != null ? 'Error' : 'Output',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: provider.errorMessage != null
                            ? Colors.red.shade900
                            : Colors.green.shade900,
                      ),
                    ),
                    const Spacer(),
                    if (provider.lastResponse?.executionTime != null)
                      Text(
                        '${provider.lastResponse!.executionTime}ms',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16),
                      onPressed: () => provider.clearOutput(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: provider.errorMessage != null
                          ? Colors.red.shade300
                          : Colors.green.shade300,
                    ),
                  ),
                  child: SelectableText(
                    provider.errorMessage ??
                        provider.lastResponse?.output ??
                        '',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
