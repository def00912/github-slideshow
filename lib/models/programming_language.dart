/// Supported programming languages
enum ProgrammingLanguage {
  python('Python', 'py'),
  javascript('JavaScript', 'js'),
  java('Java', 'java'),
  cpp('C++', 'cpp'),
  go('Go', 'go'),
  rust('Rust', 'rs'),
  typescript('TypeScript', 'ts'),
  php('PHP', 'php'),
  ruby('Ruby', 'rb'),
  swift('Swift', 'swift'),
  kotlin('Kotlin', 'kt');

  final String displayName;
  final String extension;

  const ProgrammingLanguage(this.displayName, this.extension);

  static ProgrammingLanguage fromDisplayName(String name) {
    return ProgrammingLanguage.values.firstWhere(
      (lang) => lang.displayName == name,
      orElse: () => ProgrammingLanguage.python,
    );
  }
}
