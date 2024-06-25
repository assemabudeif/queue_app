import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/error/failures.dart';
import '/core/utilities/dio_logger.dart';

/*
* This class is used to send custom requests to the server using Dio package and return the response as Either of Failure and T
* It has a generic type T which is the type of the Model model
* It has a generic type R which is the type of the response type model
*/

class CustomRequest<T> {
/*
* It has a path which is the endpoint of the request
* It has a queryParameters which is the query parameters of the request
* It has a model which is the request model
* It has a fromJson function which is used to convert the response to the required type
*/

  final String path;
  final Map<String, dynamic> queryParameters;
  final Map<String, dynamic> data;
  final T Function(Map<String, dynamic>) fromJson;

  CustomRequest({
    required this.path,
    required this.fromJson,
    this.queryParameters = const {},
    this.data = const {},
  });

/*
* It has sendGetRequest, sendPostRequest, sendPutRequest, sendDeleteRequest, sendPatchRequest methods to send the request
* It returns an Either of Failure and T
* If the request is successful it returns Right with the response model
* If the request fails it returns Left with the Failure
*/

  Future<Either<Failure, T>> sendGetRequest() async {
    try {
      final response = await DioLogger.getDio().get(
        path,
        queryParameters: queryParameters,
        data: data,
      );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }

  Future<Either<Failure, T>> sendPostRequest() async {
    try {
      final response = await DioLogger.getDio().post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }

  Future<Either<Failure, T>> sendPutRequest() async {
    try {
      final response = await DioLogger.getDio().put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }

  Future<Either<Failure, T>> sendDeleteRequest() async {
    try {
      final response = await DioLogger.getDio().delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }

  Future<Either<Failure, T>> sendPatchRequest() async {
    try {
      final response = await DioLogger.getDio().patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        log(ServerFailure.formDioException(e).message, name: 'Request Error');
        return Left(ServerFailure.formDioException(e));
      }
      log(e.toString(), name: 'Request Error');
      return Left(ServerFailure.fromResponse());
    }
  }
}
