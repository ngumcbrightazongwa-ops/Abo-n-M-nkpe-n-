class EnvConfig {
  final String environmentName;

  const EnvConfig({required this.environmentName});

  static const EnvConfig dev = EnvConfig(environmentName: 'dev');
}
