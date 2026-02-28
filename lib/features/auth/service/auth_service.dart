import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../model/user_model.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/constants/app_constants.dart';

// all firebase auth calls live here
// handles email, google, facebook and apple sign in

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // -- email login --
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: request.email.trim(),
        password: request.password,
      );

      final user = credential.user!;
      final token = await user.getIdToken() ?? '';
      final userModel = await _getUserFromFirestore(user.uid);

      return LoginResponseModel(user: userModel, token: token);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e.code);
    }
  }

  // -- email register --
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: request.email.trim(),
        password: request.password,
      );

      final user = credential.user!;
      await user.updateDisplayName(request.name);

      final userModel = UserModel(
        uid: user.uid,
        name: request.name,
        email: request.email.trim(),
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userModel.toFirestore());

      final token = await user.getIdToken() ?? '';

      return RegisterResponseModel(user: userModel, token: token);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e.code);
    }
  }

  // -- google sign in --
  Future<LoginResponseModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();;

      if (googleUser == null) {
        // user cancelled the sign in
        throw const AuthException(message: 'Google sign in was cancelled.');
      }

      final googleAuth = await googleUser.authentication;

final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user!;
      final token = await user.getIdToken() ?? '';

      // check if user already exists in firestore
      final docRef = _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        // first time google sign in - save to firestore
        final userModel = UserModel(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoUrl: user.photoURL,
          createdAt: DateTime.now(),
        );
        await docRef.set(userModel.toFirestore());
      }

      final userModel = await _getUserFromFirestore(user.uid);
      return LoginResponseModel(user: userModel, token: token);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e.code);
    }
  }

  // -- facebook sign in --
  Future<LoginResponseModel> signInWithFacebook() async {
    try {
     final result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        throw const AuthException(message: 'Facebook sign in was cancelled.');
      }

      final credential = FacebookAuthProvider.credential(
        result.accessToken!.tokenString,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user!;
      final token = await user.getIdToken() ?? '';

      // check if user already exists in firestore
      final docRef = _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        final userModel = UserModel(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoUrl: user.photoURL,
          createdAt: DateTime.now(),
        );
        await docRef.set(userModel.toFirestore());
      }

      final userModel = await _getUserFromFirestore(user.uid);
      return LoginResponseModel(user: userModel, token: token);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e.code);
    }
  }

  // -- apple sign in --
 
  // -- logout --
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e.code);
    }
  }

  // -- forgot password --
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e.code);
    }
  }

  // -- get current user --
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // -- listen to auth state changes --
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // -- helper: fetch user document from firestore --
  Future<UserModel> _getUserFromFirestore(String uid) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();

      if (!doc.exists) {
        throw const NotFoundException(
          message: 'User profile not found.',
          code: 'user-not-found',
        );
      }

      return UserModel.fromFirestore(doc);
    } catch (e) {
      rethrow;
    }
  }
}