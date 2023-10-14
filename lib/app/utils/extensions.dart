extension NonNullString on String? {
  String nonNull() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}


extension NonNullInteger on int? {
  int nonNull() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullList on List? {
  List nonNull() {
    if (this == null) {
      return const Iterable.empty().toList();
    } else {
      return this!;
    }
  }
}

