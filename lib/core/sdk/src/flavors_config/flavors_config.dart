import 'env.dart';

class FlavorConfig {
  static late FlavorConfig _instance;
  static FlavorConfig get instance => _instance;

  final String? name;
  final Map<String, dynamic> _variables;
  final Env env;

  Map<String, dynamic> get variables => _variables;

  void addRuntimeVariables(Map<String, dynamic> vars) {
    _variables.addAll(vars);
  }

  FlavorConfig._internal(this.name, this._variables, this.env);

  factory FlavorConfig({
    String? name,
    Map<String, dynamic> variables = const {},
    required Env env,
    required EnvType envType,
  }) {
    _instance = FlavorConfig._internal(name, variables, env);
    _instance._variables.addAll({
      'envModel': env.getEnvModel(envType),
    });
    return _instance;
  }

  EnvModel get envModel => _variables['envModel'];
}
