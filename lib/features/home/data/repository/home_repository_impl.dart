import 'dart:async';
import 'dart:convert';

import 'package:tdd_clean_architecture_riverpod/core/network/network_io_service.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/data/data_mapper/home_data_mapper.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/data/models/technology_posts_response_dto.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/repository/home_repository.dart';

import '../../../../core/environment/domain_config.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkIOService networkIOService;

  HomeRepositoryImpl({required this.networkIOService});

  @override
  Future<List<TechnologyPostsEntity>> getTechnologyUpdates() async{
    String baseUrl = DomainConfig().baseUrl;
    String url = "${baseUrl}posts";
    final response = await networkIOService.get(url);
    final parsed = jsonDecode(response);
    if(parsed is List){
      List<TechnologyPostsResponseDto> technologyPostsResponseDtoList = List.from(parsed)
          .map((json) => TechnologyPostsResponseDto.fromJson(json))
          .whereType<TechnologyPostsResponseDto>()
          .toList();
      return technologyPostsResponseDtoList.toTechnologyPostsEntity();
    } else {
      // Handle unexpected response format
      return [];
    }
  }
}