// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:planets_app/core/data/network/models/http_service_response.dart';
import 'package:planets_app/core/presentation/utils/constants.dart';

class HttpService {
  String url = constants.domain;
  String timeoutMessage =
      'We couldn\'t connect to our servers. Try again in a moment.';

  Future<HttpServiceResponse> get(
      {required String endpoint, http.Client? client}) async {
    http.Client? httpClient = client ?? http.Client();

    try {
      Response response = await httpClient
          .get(Uri.parse("$url$endpoint"))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: (() => throw TimeoutException("{'error': 'Timeout'}")),
          );
      return validateResponse(response);
    } on TimeoutException catch (_) {
      return HttpServiceResponse(success: false, message: timeoutMessage);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "$e");
    }
  }

  Future<HttpServiceResponse> post({
    required String endpoint,
    required Map<String, dynamic> body,
    http.Client? client,
  }) async {
    log(
      '[http-service] [post]'
      '\nbody: ${json.encode(body)}',
    );
    log('Servicio: $url$endpoint');
    http.Client? httpClient = client ?? http.Client();
    try {
      Response response = await httpClient
          .post(Uri.parse("$url$endpoint"), body: json.encode(body), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }).timeout(
        const Duration(seconds: 250),
        onTimeout: (() => throw TimeoutException("{'error': 'Timeout'}")),
      );
      return await validateResponse(response);
    } on SocketException catch (_) {
      return HttpServiceResponse(
          success: false,
          errorCode: 250,
          message:
              "Parece que no tienes internet. Revisa tu conexión e inténtalo de nuevo.");
    } on TimeoutException catch (_) {
      return HttpServiceResponse(success: false, message: timeoutMessage);
    } on ClientException catch (_) {
      return HttpServiceResponse(
          success: false,
          message:
              "Parece que no tienes internet. Revisa tu conexión e inténtalo de nuevo.");
    } catch (e) {
      return HttpServiceResponse(
          success: false, body: "$e", message: "Error: $e");
    }
  }

  Future<HttpServiceResponse> put(
      {required String endpoint,
      required Map<String, dynamic> body,
      http.Client? client}) async {
    http.Client? httpClient = client ?? http.Client();
    try {
      Response response = await httpClient.put(Uri.parse("$url$endpoint"),
          body: json.encode(body),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }).timeout(const Duration(seconds: 10),
          onTimeout: (() => throw TimeoutException("{'error': 'Timeout'}")));

      return validateResponse(response);
    } on TimeoutException catch (_) {
      return HttpServiceResponse(success: false, message: timeoutMessage);
    } catch (e) {
      return HttpServiceResponse(
          success: false, message: "e", body: "Error: $e");
    }
  }

  Future<HttpServiceResponse> delete(
      {required String endpoint,
      Map<String, dynamic>? body,
      http.Client? client}) async {
    http.Client? httpClient = client ?? http.Client();
    try {
      Response response = await httpClient.delete(Uri.parse("$url$endpoint"),
          body: body != null ? json.encode(body) : null,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          });

      return validateResponse(response);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "e", body: "$e");
    }
  }

  Future<HttpServiceResponse> multipart({
    required String endpoint,
    required List<File> files,
    required String queryId,
  }) async {
    try {
      /// quitar esto y dejar solo la url luego de actualizar en firebase
      String docUrl = "https://machine-learning-api-qlmqmy4cza-uc.a.run.app";

      log('$docUrl$endpoint');
      var request =
          http.MultipartRequest('POST', Uri.parse('$docUrl$endpoint'));

      request.fields.addAll({'id': queryId});

      /// Agregando files al request...
      for (var file in files) {
        request.files.add(
          http.MultipartFile.fromBytes(
            "files[]",
            await file.readAsBytes(),
            filename: file.path,
            //   contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      Response response = await http.Response.fromStream(await request.send());
      Map<String, dynamic> body = json.decode(response.body);
      log("OCR: ${response.body}");
      if (response.statusCode == 200) {
        return HttpServiceResponse(
            success: true, message: body["mensaje"], body: response.body);
      }
      return HttpServiceResponse(
          success: false, message: body["mensaje"], body: response.body);
    } catch (e) {
      return HttpServiceResponse(success: false, message: "$e", body: "$e");
    }
  }

  /// Necesario para validar la respuesta que se obtiene desde el back
  // ignore: long-method
  Future<HttpServiceResponse> validateResponse(Response response) async {
    bool success = false;
    String message = "";
    log('[http-service] [validateResponse]');
    log('\ncode: ${response.statusCode}');
    log('\nrequest: ${response.request}');
    log(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        success = true;
        break;
      case 401:
      case 404:
      case 408:
      case 500:
      case 503:
        success = false;
        message =
            "Servicio no disponible en este momento. Contáctate con el administrador";
        return HttpServiceResponse(
            success: false, errorCode: response.statusCode, message: message);

      default:
        return HttpServiceResponse(
            success: false,
            errorCode: 100,
            message:
                "Servicio no disponible en este momento. Contáctate con el administrador.");
    }

    Map<String, dynamic> body = json.decode(response.body);

    if (body.containsKey("idError")) {
      if (body["idError"] != 0) {
        return HttpServiceResponse(
            success: false,
            errorCode: body["idError"],
            message: body["mensaje"]);
      }
    }
    return HttpServiceResponse(
        success: success, message: response.body, body: response.body);
  }
}

final HttpService httpService = HttpService();
