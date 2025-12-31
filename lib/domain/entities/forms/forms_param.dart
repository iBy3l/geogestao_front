import '/domain/entities/forms/access_mode.dart';

class FormsParam {
  final String? id;
  final String name;
  final Map<String, dynamic> config;
  final Map<String, dynamic>? theme;
  final String? redirectUrl;
  final bool? showBranding;
  final AccessMode accessMode;
  final String? password;
  final bool? isPublished;

  FormsParam({this.id, required this.name, required this.config, this.theme, this.redirectUrl, this.showBranding, required this.accessMode, this.password, this.isPublished = true});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['p_name'] = name;
    if (config.isNotEmpty) {
      map['p_config'] = config;
    }
    if (id != null) {
      map['p_form_id'] = id;
    }
    if (theme != null) {
      map['p_theme'] = theme;
    }
    if (redirectUrl != null) {
      map['p_redirect_url'] = redirectUrl;
    }
    if (showBranding != null) {
      map['p_show_branding'] = showBranding;
    }
    map['p_access_mode'] = accessMode.name;
    if (password != null) {
      map['p_password'] = password;
    }
    if (isPublished != null) {
      map['p_is_published'] = isPublished;
    }
    return map;
  }
}
