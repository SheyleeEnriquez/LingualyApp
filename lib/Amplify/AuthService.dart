import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthService {
  Future<AuthUser?> getCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return user;
    } on AuthException catch (e) {
      print('Error getting current user: ${e.message}');
      return null;
    }
  }
// Obtener atributos detallados del usuario
  Future<Map<String, String>> getUserAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      Map<String, String> userInfo = {};

      for (var attribute in attributes) {
        userInfo[attribute.userAttributeKey.key] = attribute.value;
      }

      return userInfo;
    } on AuthException catch (e) {
      print('Error fetching user attributes: ${e.message}');
      return {};
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('No user is currently signed in');
      }

      final attributes = await getUserAttributes();

      return {
        'userId': user.userId,
        'username': user.username,
        'attributes': attributes,
      };
    } catch (e) {
      print('Error getting user info: $e');
      return {};
    }
  }

  // Sign up a new user
  Future<String?> signUp({
    required String username,
    required String password,
    required String email,
    required String fullname,
  }) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.name: fullname,
      };
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      return await _handleSignUpResult(result);
    } on AuthException catch (e) {
      return ('Error signing up user: ${e.message}');
    }
  }

  Future<String?> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        return _handleCodeDelivery(codeDeliveryDetails);
      case AuthSignUpStep.done:
        return ('Sign up is complete');
      default:
        return 'Unexpected sign-up step: ${result.nextStep.signUpStep}';
    }
  }

  String _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    return(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
          'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.'
    );
  }

  Future<String?> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      return await _handleSignUpResult(result);
    } on AuthException catch (e) {
      return ('Error confirming user: ${e.message}');
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

  //Reset password
  Future<String> resetPassword(String username) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      return await _handleResetPasswordResult(result);
    } on AuthException catch (e) {
      return ('Error resetting password: ${e.message}');
    }
  }

  Future<String> _handleResetPasswordResult(ResetPasswordResult result) async {
    switch (result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        return _handleCodeDelivery(codeDeliveryDetails);
      case AuthResetPasswordStep.done:
        return ('Successfully reset password');
    }
  }

  Future<void> confirmResetPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  Future<bool> isUserSignedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return session.isSignedIn;
    } on AuthException catch (e) {
      print('Error checking auth status: ${e.message}');
      return false;
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
