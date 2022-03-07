import 'package:http/http.dart';
import 'package:http/http.dart' as http; // for the image function
import 'dart:convert';
import 'dart:io';

class HttpService {
  // FOR IOS AND CHROME WEB : LOCALHOST WORKS FINE
  // FOR IOS AND CHROME WEB : LOCALHOST WORKS FINE
  // FOR IOS AND CHROME WEB : LOCALHOST WORKS FINE
  // final String serverAPI = "http://localhost:3000/";
  // final String serverAPI_image = "http://localhost:3000/";

  // FOR ANDRIOD AVD cos ANDROID EMULATOR has issues with localhost
  // FOR ANDRIOD AVD cos ANDROID EMULATOR has issues with localhost
  // FOR ANDRIOD AVD cos ANDROID EMULATOR has issues with localhost
  // final String serverAPI = "http://10.0.2.2:3000/";
  // final String serverAPI_image = "http://10.0.2.2:3000/";

  // USING SPECIFIC IP ADDRESS
  // USING SPECIFIC IP ADDRESS
  // USING SPECIFIC IP ADDRESS
  // final String serverAPI = "http://192.168.8.197:3000/";
  // final String serverAPI_image = "http://192.168.8.197:3000/";
  final String serverAPI = "http://192.168.0.126:3000/";
  final String serverAPI_image = "http://192.168.0.126:3000/";

  // GET COUNTRIES
  // GET COUNTRIES
  // GET COUNTRIES
  Future fetchSignupCriteria() async {
    Response response;
    try {
      response =
          await get(Uri.parse(serverAPI + 'api1.0/signup/signupCriteria'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // SUBMIT NEW USER INFORMATION
  // SUBMIT NEW USER INFORMATION
  // SUBMIT NEW USER INFORMATION
  Future signupAPIfunction(Map<String, dynamic> signupdata) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/signup/addMember'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(signupdata),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // LOGIN USER
  // LOGIN USER
  // LOGIN USER
  Future loginAPIfunction(Map<String, dynamic> logindata) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/login/authenticateUser'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(logindata),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // GET INTEREST
  // GET INTEREST
  // GET INTEREST
  Future fetchSetupInterests() async {
    Response response;
    try {
      response =
          await get(Uri.parse(serverAPI + 'api1.0/signup/setupInterests'));

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // POST INTERESTS
  // POST INTERESTS
  Future postSetupInterests(interestData) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/signup/addInterests'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(interestData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // EDIT PROFILE
  // EDIT PROFILE
  Future editprofileAPIfunction(profileData) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/editprofile/profileData'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(profileData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // CHANGE PASSWORD
  // CHANGE PASSWORD
  Future changePasswordAPIfunction(changePasswordData) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/settings/changePassword'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(changePasswordData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  Future uploadImage(filePath) async {
    // String fileName = filePath.path.split("/").last;

    // // Map<String, String> requestHeaders = {
    // //   "Content-Type": "application/json",
    // //   'Content-Disposition': 'attachment; filename=$fileName'
    // // };

    List<int> imageBytes = File(filePath.path).readAsBytesSync();
    String base64Image = base64Encode(File(filePath.path).readAsBytesSync());
    // // var request = http.Request('POST', Uri.parse(serverAPI + 'updateProfilePhoto'));
    // // request.headers.addAll(requestHeaders);
    // // request.body = {'imageBytes':'jkj'};
    // // var res = await request.send();
    print('started');
    // print(base64Image);
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'updateProfilePhoto'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'base64': base64Image}),
      );

      print(response.statusCode);

      // if (response.statusCode == 200) {
      //   return json.decode(response.body);
      // } else {
      //   return {'status': 'error', 'message': 'network / api error'};
      // }

    } catch (e) {
      // print(e);
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // SEND STATUS TEXT
  // SEND STATUS TEXT
  Future sendStatusTextAPIfunction(statusValues) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/status/sendStatusText'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(statusValues),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      print(e);
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // GET ACTIVE MEMBERS
  // GET ACTIVE MEMBERS
  // GET ACTIVE MEMBERS
  Future fetchActiveMembersPopular(sessionValue) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/defaultActiveMembersPopular'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(sessionValue),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // GET ACTIVE MEMBERS
  // GET ACTIVE MEMBERS
  // GET ACTIVE MEMBERS
  Future fetchActiveMembersGeneral(sessionValue) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/defaultActiveMembersGeneral'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(sessionValue),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // GET FILTERED MEMBERS
  // GET FILTERED MEMBERS
  // GET FILTERED MEMBERS
  Future fetchMembersFiltered(filterCondition) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriendsFilterRoom/default'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(filterCondition),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // SEND ADD REQUEST
  // SEND ADD REQUEST
  // SEND ADD REQUEST
  Future sendAddRequestAPIfunction(userToIdMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/sendAddRequest'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userToIdMap),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // REMOVE ADD REQUEST
  // REMOVE ADD REQUEST
  // REMOVE ADD REQUEST
  Future removeAddRequestAPIfunction(userToIdMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/removeAddRequest'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userToIdMap),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // ACCEPT ADD REQUEST
  // ACCEPT ADD REQUEST
  // ACCEPT ADD REQUEST
  Future acceptAddRequestAPIfunction(userToIdMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/acceptAddRequest'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userToIdMap),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // REJECT ADD REQUEST
  // REJECT ADD REQUEST
  // REJECT ADD REQUEST
  Future rejectAddRequestAPIfunction(userToIdMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/rejectAddRequest'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userToIdMap),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // REMOVE FRIEND
  // REMOVE FRIEND
  // REMOVE FRIEND
  // REMOVE FRIEND
  Future removeFriendAPIfunction(userToIdMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/removeFriend'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userToIdMap),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // BLOCK PERSON
  // BLOCK PERSON
  // BLOCK PERSON
  // BLOCK PERSON
  Future blockPersonAPIfunction(userToIdMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/makefriends/blockPerson'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userToIdMap),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Server Error'};
    }
  }

  // FETCH NOTIFICATION COUNT
  // FETCH NOTIFICATION COUNT
  // FETCH NOTIFICATION COUNT
  Future fetchNotificationCount(_session) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/notifications/getNotificationsCount'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'session': _session}),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // FETCH NOTIFICATION VALUES
  // FETCH NOTIFICATION VALUES
  // FETCH NOTIFICATION VALUES
  Future fetchNotificationRequestValues(_session) async {
    Response response;
    try {
      response = await post(
        Uri.parse(
            serverAPI + 'api1.0/notifications/getNotificationRequestValues'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'myId': _session}),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // FETCH NOTIFICATION VALUES
  // FETCH NOTIFICATION VALUES
  // FETCH NOTIFICATION VALUES
  Future fetchNotificationRejectionValues(_session) async {
    Response response;
    try {
      response = await post(
        Uri.parse(
            serverAPI + 'api1.0/notifications/getNotificationRejectionValues'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'myId': _session}),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // FETCH CONTACTS VALUES
  // FETCH CONTACTS VALUES
  // FETCH CONTACTS VALUES
  Future fetchContactValues(_id) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/contacts/getContacts'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'myId': _id}),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // FETCH MOMENTS VALUES
  // FETCH MOMENTS VALUES
  // FETCH MOMENTS VALUES
  Future fetchFriendsMomentsValues(_id) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/status/getFriendsMoments'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'myId': _id}),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // CHANGE PASSWORD
  // CHANGE PASSWORD
  Future changeHideStatusAPIfunction(profileVisibilityStatusMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/settings/changeHideStatus'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(profileVisibilityStatusMap),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // SEND VERIFICATION EMAIL
  // SEND VERIFICATION EMAIL
  // SEND VERIFICATION EMAIL
  Future sendVerificationCodeToEmail(sendVerificationToMap) async {
    Response response;
    try {
      response = await post(
        Uri.parse(serverAPI + 'api1.0/settings/sendVerificationCodeToEmail'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'id': sendVerificationToMap}),
      );

      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'network / error 500'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'network error / server error'};
    }
  }

  // End of Class
}
