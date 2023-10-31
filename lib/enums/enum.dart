enum Version { release }

extension VersionString on Version {
  String get val {
    switch (this) {
      case Version.release:
        return '1.0';
    }
  }
}

enum Database { peaje, registros }

extension DatabaseString on Database {
  String get val {
    switch (this) {
      case Database.peaje:
        return 'peajedb';
      case Database.registros:
        return 'registrodb';
    }
  }
}
