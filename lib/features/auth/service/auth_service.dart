import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/constants/app_constants.dart';

// all firebase auth calls live here
// the repository talks to this, the viewmodel never touches this directly

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // -- login --
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

  // -- register --
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: request.email.trim(),
        password: request.password,
      );

      final user = credential.user!;

      // update display name in firebase auth
      await user.updateDisplayName(request.name);

      // save extra user data to firestore
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

  // -- logout --
  Future<void> logout() async {
    try {
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