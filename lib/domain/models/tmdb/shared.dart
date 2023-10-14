import 'package:equatable/equatable.dart';
import 'package:letterboxd/app/utils/constants.dart';

class DetailableIntModel extends Equatable {
  final int id;
  final String name;

  const DetailableIntModel.initial()
      : this(id: Empty.integer, name: Empty.string);
  const DetailableIntModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class DetailableStringModel extends Equatable {
  final String id;
  final String name;

  const DetailableStringModel.initial()
      : this(id: Empty.string, name: Empty.string);
  const DetailableStringModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
