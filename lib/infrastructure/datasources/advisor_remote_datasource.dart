import 'dart:convert';

import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:advisor_app/infrastructure/models/advice_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AdvisorRemoteDatasource {
  /// request für einen zufälligen Rat von der api
  /// server exception soll geworfen werden, wenn response code != 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdvisorRemoteDatasourceImpl extends AdvisorRemoteDatasource {
  final http.Client client;

  AdvisorRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get(
        Uri.parse('https://api.adviceslip.com/advice'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return AdviceModel.fromJson(responseBody['slip']);
    } else {
      throw ServerException();
    }
  }
}
