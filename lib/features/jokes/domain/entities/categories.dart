import 'package:equatable/equatable.dart';

class Categories extends Equatable{
  final List<String> names;

  const Categories({required this.names});

  @override
  List<Object?> get props => [names];


  @override
  String toString() {
    return 'Categories(name: $names)';
  }
}
