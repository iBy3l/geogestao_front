import 'dart:html' as html;

class Meta {
  String? title;
  String? description;
  String? keywords;
  String? author;
  String? viewport;
  String? robots;
  String? ogTitle;
  String? ogDescription;
  String? ogImage;
  String? ogUrl;
  String? ogType;
  String? ogSiteName;
  String? ogLocale;
  String? ogLocaleAlternate;
  String? h1;
  String? h2;
  String? h3;
  String? h4;
  String? h5;
  String? h6;

  Meta({
    this.title,
    this.description,
    this.keywords,
    this.author,
    this.viewport,
    this.robots,
    this.ogTitle,
    this.ogDescription,
    this.ogImage,
    this.ogUrl,
    this.ogType,
    this.ogSiteName,
    this.ogLocale,
    this.ogLocaleAlternate,
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
  });

  Meta getMeta() {
    return Meta(
      title: title,
      description: description,
      keywords: keywords,
      author: author,
      viewport: viewport,
      robots: robots,
      ogTitle: ogTitle,
      ogDescription: ogDescription,
      ogImage: ogImage,
      ogUrl: ogUrl,
      ogType: ogType,
      ogSiteName: ogSiteName,
      ogLocale: ogLocale,
      ogLocaleAlternate: ogLocaleAlternate,
      h1: h1,
      h2: h2,
      h3: h3,
      h4: h4,
      h5: h5,
      h6: h6,
    );
  }

  void setMeta() {
    if (title != null) {
      setPageTitle(title!);
    }
    if (description != null) {
      setPageDescription(description!);
    }
    if (keywords != null) {
      setPageKeywords(keywords!);
    }
    if (author != null) {
      setPageAuthor(author!);
    }
    if (viewport != null) {
      setPageViewport(viewport!);
    }
    if (robots != null) {
      setPageRobots(robots!);
    }
    if (ogTitle != null) {
      setPageOgTitle(ogTitle!);
    }
    if (ogDescription != null) {
      setPageOgDescription(ogDescription!);
    }
    if (ogImage != null) {
      setPageOgImage(ogImage!);
    }
    if (ogUrl != null) {
      setPageOgUrl(ogUrl!);
    }
    if (ogType != null) {
      setPageOgType(ogType!);
    }
    if (ogSiteName != null) {
      setPageOgSiteName(ogSiteName!);
    }
    if (ogLocale != null) {
      setPageOgLocale(ogLocale!);
    }
    if (ogLocaleAlternate != null) {
      setPageOgLocaleAlternate(ogLocaleAlternate!);
    }
    if (h1 != null) {
      addH1(h1!);
    }
    if (h2 != null) {
      addH2(h2!);
    }
    if (h3 != null) {
      addH3(h3!);
    }
    if (h4 != null) {
      addH4(h4!);
    }
    if (h5 != null) {
      addH5(h5!);
    }
    if (h6 != null) {
      addH6(h6!);
    }
  }

  void clearMeta() {
    setPageTitle('');
    setPageDescription('');
    setPageKeywords('');
    setPageAuthor('');
    setPageViewport('');
    setPageRobots('');
    setPageOgTitle('');
    setPageOgDescription('');
    setPageOgImage('');
    setPageOgUrl('');
    setPageOgType('');
    setPageOgSiteName('');
    setPageOgLocale('');
    setPageOgLocaleAlternate('');
    addH1('');
    addH2('');
    addH3('');
    addH4('');
    addH5('');
    addH6('');
  }
}

initializeSEO() {
  setPageTitle('Sympllizy');
  setPageDescription('Sympllizy is a platform for managing your tasks and projects efficiently.');
  setPageKeywords('task management, project management, productivity');
  setPageAuthor('Your Name');
  setPageViewport('width=device-width, initial-scale=1.0');
  setPageRobots('index, follow');
  setPageOgTitle('Sympllizy');
  setPageOgDescription('Sympllizy is a platform for managing your tasks and projects efficiently.');
  setPageOgImage('assets/images/logos/logo_sympllizy.png');
  setPageOgUrl('https://sympllizy.com');
  setPageOgType('website');
  setPageOgSiteName('Sympllizy');
  setPageOgLocale('en_US');
  setPageOgLocaleAlternate('es_ES');
  setPageOgType('website');
  setPageOgSiteName('Sympllizy');
  setPageOgLocale('en_US');
  setPageOgLocaleAlternate('es_ES');
  setPageOgType('website');
  setPageOgSiteName('Sympllizy');
  setPageOgLocale('en_US');
  setPageOgLocaleAlternate('es_ES');
  setPageOgType('website');
}

void setPageTitle(String title) {
  html.document.title = title;
}

void setPageDescription(String description) {
  final meta = html.MetaElement()
    ..name = 'description'
    ..content = description;
  html.document.head?.append(meta);
}

void setPageKeywords(String keywords) {
  final meta = html.MetaElement()
    ..name = 'keywords'
    ..content = keywords;
  html.document.head?.append(meta);
}

void setPageAuthor(String author) {
  final meta = html.MetaElement()
    ..name = 'author'
    ..content = author;
  html.document.head?.append(meta);
}

void setPageViewport(String viewport) {
  final meta = html.MetaElement()
    ..name = 'viewport'
    ..content = viewport;
  html.document.head?.append(meta);
}

void setPageRobots(String robots) {
  final meta = html.MetaElement()
    ..name = 'robots'
    ..content = robots;
  html.document.head?.append(meta);
}

void setPageOgTitle(String ogTitle) {
  final meta = html.MetaElement()
    ..name = 'og:title'
    ..content = ogTitle;
  html.document.head?.append(meta);
}

void setPageOgDescription(String ogDescription) {
  final meta = html.MetaElement()
    ..name = 'og:description'
    ..content = ogDescription;
  html.document.head?.append(meta);
}

void setPageOgImage(String ogImage) {
  final meta = html.MetaElement()
    ..name = 'og:image'
    ..content = ogImage;
  html.document.head?.append(meta);
}

void setPageOgUrl(String ogUrl) {
  final meta = html.MetaElement()
    ..name = 'og:url'
    ..content = ogUrl;
  html.document.head?.append(meta);
}

void setPageOgType(String ogType) {
  final meta = html.MetaElement()
    ..name = 'og:type'
    ..content = ogType;
  html.document.head?.append(meta);
}

void setPageOgSiteName(String ogSiteName) {
  final meta = html.MetaElement()
    ..name = 'og:site_name'
    ..content = ogSiteName;
  html.document.head?.append(meta);
}

void setPageOgLocale(String ogLocale) {
  final meta = html.MetaElement()
    ..name = 'og:locale'
    ..content = ogLocale;
  html.document.head?.append(meta);
}

void setPageOgLocaleAlternate(String ogLocaleAlternate) {
  final meta = html.MetaElement()
    ..name = 'og:locale:alternate'
    ..content = ogLocaleAlternate;
  html.document.head?.append(meta);
}

void addH1(String text) {
  final h1 = html.HeadingElement.h1()..text = text;
  html.document.body?.append(h1);
}

void addH2(String text) {
  final h2 = html.HeadingElement.h2()..text = text;
  html.document.body?.append(h2);
}

void addH3(String text) {
  final h3 = html.HeadingElement.h3()..text = text;
  html.document.body?.append(h3);
}

void addH4(String text) {
  final h4 = html.HeadingElement.h4()..text = text;
  html.document.body?.append(h4);
}

void addH5(String text) {
  final h5 = html.HeadingElement.h5()..text = text;
  html.document.body?.append(h5);
}

void addH6(String text) {
  final h6 = html.HeadingElement.h6()..text = text;
  html.document.body?.append(h6);
}
