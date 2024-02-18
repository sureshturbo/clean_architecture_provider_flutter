import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_app/Constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_app/Provider/Database/db_provider.dart';
import 'package:rest_api_app/Screens/Authentication/login.dart';
import 'package:rest_api_app/Screens/TaskPage/home_page.dart';
import 'package:rest_api_app/Utils/routers.dart';

import '../../Screens/Products/Product_list.dart';
import '../../Screens/Products/home.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/v2/login";

    final body = {
      // "firstName": firstName,
      // "lastName": lastName,
      "email": email,
      "password": password
    };
    print(body);

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));
      print(req);
      print(url);
      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['error'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  // void loginUser({
  //   required String email,
  //   required String password,
  //   BuildContext? context,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   String url = "$requestBaseUrl/v2/login";
  //
  //   Map body = {
  //     "email": email,
  //     "password": password
  //   };
  //   print(body);
  //   print(url);
  //
  //   try {
  //     var req =
  //         await http.post(Uri.parse(url), body: json.encode(body), headers: {"Accept" : "application/json"});
  //     print(req);
  //     if (req.statusCode == 200) {
  //       var res = json.decode(req.body);
  //       print(res);
  //       _isLoading = false;
  //       _resMessage = "Login successfull!";
  //       notifyListeners();
  //
  //       ///Save users data and then navigate to homepage
  //       // final userId = res['user']['id'];
  //       // final token = res['authToken'];
  //       // DatabaseProvider().saveToken(token);
  //       // DatabaseProvider().saveUserId(userId);
  //       // PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
  //     } else {
  //       final res = json.decode(req.body);
  //
  //       _resMessage = res['message'];
  //
  //       print(res);
  //       _isLoading = false;
  //       notifyListeners();
  //     }
  //   } on SocketException catch (_) {
  //     _isLoading = false;
  //     _resMessage = "Internet connection is not available`";
  //     notifyListeners();
  //   } catch (e) {
  //     _isLoading = false;
  //     _resMessage = "Please try again`";
  //     notifyListeners();
  //
  //     print(":::: $e");
  //   }
  // }
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/v2/login";

    Map body = {
      "email": email,
      "password": password
    };

    print("Request URL: $url");
    print("Request Body: $body");
   // login();
    try {
      var response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers:  {
          "Content-Type": "application/json",
        },
      );

      print("Response: $response");

      if (response.statusCode == 200) {
        print('hi');

        var result = jsonDecode(response.body);
        print(result);

          _isLoading = false;
          _resMessage = "Login successful!";
          notifyListeners();

          // Save users data and then navigate to homepage
          // ...
        ///Save users data and then navigate to homepage
              var userId = result['user_id'];
              final token = result['token'];
              DatabaseProvider().saveToken(token);
              DatabaseProvider().saveUserId(userId);
              PageNavigator(ctx: context).nextPageOnly(page:  MyHomePage());

      }
    } on SocketException catch (_) {
      _handleError("Internet connection is not available");
    } catch (e) {
      _handleError("Exception: $e");
    }
  }

  login() async{
    Map data = {
      'email': 'root@gegomlm.com',
      'password': 'root'
    };
    print(data);
    var url = requestBaseUrl + '/v2/login';
    print(url);
    try{
      var response =await http.post(Uri.parse(url), body: data,
        headers: {"Accept": "application/json"},
      );

      if(response.statusCode == 200){
        print('hi');
        var result = jsonDecode(response.body);
        print(result);
      }
      if(response.statusCode == 302){
        var result = jsonDecode(response.body);
        print(result);

      }
    }on Exception catch (e){
      if(e.toString().contains('SocketException')){

      }

    }
  }
  void _handleError(String errorMessage) {
    _isLoading = false;
    _resMessage = errorMessage;
    notifyListeners();
  }


  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
