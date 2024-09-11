
import 'package:klontong/domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  ResponseModel.fromJSON(Map<String, dynamic> json)
      : super(
          error: json['error'],
          message: json['message'],
          data: json['data']??'',
        );

  Map<String, dynamic> toJson() => {
        'error':error,
        'message':message,
        'data':data,
      };
}