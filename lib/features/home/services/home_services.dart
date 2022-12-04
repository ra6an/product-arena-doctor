//

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_application/constants/error_handling.dart';
import 'package:flutter_application/constants/global_variables.dart';
import 'package:flutter_application/constants/utils.dart';
import 'package:flutter_application/models/patients_model.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Patients>> fetchAllPatients(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Patients> patientsList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/patients/get-patients'),
        headers: {
          'content-type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // print(jsonDecode(res.body)[0]);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            patientsList.add(
              Patients.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return patientsList;
  }
}
