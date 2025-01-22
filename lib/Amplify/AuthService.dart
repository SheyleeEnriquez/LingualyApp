import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  // Sign up a new user
  Future<String?> signUp({
    required String username,
    required String password,
    required String email,
    required String fullName,
  }) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email,
        CognitoUserAttributeKey.name: fullName,
      };

      await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      return null; // Null means success
    } on AuthException catch (e) {
      return e.message; // Return the error message for UI feedback
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Sign in an existing user
  Future<String?> signIn(String email, String password) async {
    try {
      await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      return null; // Null means success
    } on AuthException catch (e) {
      return e.message; // Return the error message for UI feedback
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Fetch JWT token
  Future<JsonWebToken?> getJwtToken() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      final tokens = (session as CognitoAuthSession).userPoolTokensResult.value;

      // Extract the idToken as a String
      return tokens?.idToken ?? null;
    } catch (e) {
      print('Failed to get token: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('Sign out successful');
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}
