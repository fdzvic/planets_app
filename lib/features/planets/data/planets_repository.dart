import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:planets_app/core/data/network/http_service.dart';
import 'package:planets_app/features/planets/domain/list_planets_response.dart';

class PlanetsRepository {
  final http.Client client;

  PlanetsRepository({required this.client});

  Future<ListPlanetsResponse> getListPlanets() async {
    try {
      var response = await httpService.get(
        endpoint: '/planets#',
        client: client,
      );
      if (response.success == true) {
        return ListPlanetsResponse.fromJson(json.decode(response.body!));
      } else {
        throw response;
      }
    } catch (e) {
      rethrow;
    }
  }
}

final planetsRepositoryProvider = Provider<PlanetsRepository>(
  (ref) => PlanetsRepository(client: http.Client()),
);
