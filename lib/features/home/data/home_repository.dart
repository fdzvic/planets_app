import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRepository {
 
}

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>(
  (ref) => HomeRepository(),
);