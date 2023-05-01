import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Auth{
  void initialize(SharedPreferences prefs, Dio dio,String username, String password) async{
      var params = {
        "username" : username,
        "password" : password,
      };
      Response response = await dio.post("/api/tokens",options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
        data : jsonEncode(params),
      );
      String authToken = response.data['authToken'];
      String dataSource = response.data['dataSource'];
      await prefs.setString('authToken', authToken);
      await prefs.setString('dataSource', dataSource);
  }
}

class ListConnections{
  Future<Response> getAllConnections(SharedPreferences prefs, Dio dio) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/connections";
    Response response = await dio.get(relativeUrl,queryParameters: params);
    return response;
  }
}

class ConnectionDetails{
  Future<Response> getDetails(SharedPreferences prefs, Dio dio, String connectionIdentifier) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/connections/$connectionIdentifier";
    Response response = await dio.get(relativeUrl,queryParameters: params);
    return response;
  }
}

class ConnectionParameters{
  Future<Response> getParams(SharedPreferences prefs, Dio dio, String connectionIdentifier) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/connections/$connectionIdentifier/parameters";
    Response response = await dio.get(relativeUrl, queryParameters: params);
    return response;
  }
}

class ActiveConnections{
  Future<Response> getActiveConnections(SharedPreferences prefs, Dio dio) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/activeConnections";
    Response response = await dio.get(relativeUrl, queryParameters: params);
    return response;
  }
}

class KillConnection{
  void attemptKillConnection(SharedPreferences prefs, Dio dio, String uniqueConnectionIdentifier) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/activeConnections";
    await dio.patch(relativeUrl,queryParameters: params,options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    }), data: {"op" : "remove", "path" : "/$uniqueConnectionIdentifier",});
  }
}

class ShareConnection{
  //TODO: Implement this
}

class CreateConnection{
  Future<Response> attemptToCreateConnection(SharedPreferences prefs, Dio dio, String protocol,String nameOfTheConnection, String hostname, String username, String password) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/connections";
    var body = {
        "parentIdentifier": "ROOT",
        "name": "{{$nameOfTheConnection}}",
        "protocol": protocol,
        "parameters": {
          "port": "",
          "read-only": "",
          "swap-red-blue": "",
          "cursor": "",
          "color-depth": "",
          "clipboard-encoding": "",
          "disable-copy": "",
          "disable-paste": "",
          "dest-port": "",
          "recording-exclude-output": "",
          "recording-exclude-mouse": "",
          "recording-include-keys": "",
          "create-recording-path": "",
          "enable-sftp": "true",
          "sftp-port": "",
          "sftp-server-alive-interval": "",
          "enable-audio": "",
          "audio-servername": "",
          "sftp-directory": "",
          "sftp-root-directory": "",
          "sftp-passphrase": "",
          "sftp-private-key": "",
          "sftp-username": "",
          "sftp-password": "",
          "sftp-host-key": "",
          "sftp-hostname": "",
          "recording-name": "",
          "recording-path": "",
          "dest-host": "",
          "password": password,
          "username": username,
          "hostname": hostname,
        },
        "attributes": {
          "max-connections": "",
          "max-connections-per-user": "",
          "weight": "",
          "failover-only": "",
          "guacd-port": "",
          "guacd-encryption": "",
          "guacd-hostname": ""
        }
    };
    Response response = await dio.post(relativeUrl,queryParameters: params, options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",}), data: body);
    return response;
  }
}

class UpdateConnection{
  Future<Response> updateConnection(SharedPreferences prefs, Dio dio, var body, String connectionNumber) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/connections/$connectionNumber";
    Response response = await dio.post(relativeUrl,queryParameters: params, options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",}), data: body);
    return response;
  }
}

class DeleteConnection{
  Future<Response> deleteConnection(SharedPreferences prefs, Dio dio, String connectionNumber) async{
    var params = {
      "token" : prefs.getString('authToken'),
    };
    String dataSource = prefs.getString('dataSource') ?? '';
    String relativeUrl = "/api/session/data/$dataSource/connections/$connectionNumber";
    Response response = await dio.delete(relativeUrl,queryParameters: params);
    return response;
  }
}







