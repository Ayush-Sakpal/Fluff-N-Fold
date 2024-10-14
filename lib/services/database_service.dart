import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../utils.dart';
import '../models/user_profile.dart';
import 'auth_service.dart';

class DatabaseService{

  final GetIt _getIt = GetIt.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late AuthService _authService;

  CollectionReference? _userCollection;
  CollectionReference? _chatCollection;

  DatabaseService(){
    _setupCollectionReferences();
    _authService = _getIt.get<AuthService>();
  }

  void _setupCollectionReferences(){
    _userCollection = _firebaseFirestore.collection('users').withConverter<UserProfile>(
        fromFirestore: (snapshot, _) {
          print(snapshot);
          return UserProfile.fromJson(snapshot.data()!);
          },
        toFirestore: (userProfile, _) => userProfile.toJson()
    );

    _chatCollection = _firebaseFirestore.collection("chats").withConverter<Chat>(
        fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
        toFirestore: (chat, _) => chat.toJson()
    );
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async{
    await _userCollection?.doc(userProfile.uid).set(userProfile);
    print(userProfile.uid);
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfiles(){
    return _userCollection?.where(
        "uid",
        isNotEqualTo: _authService.user!.uid
    ).snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final result = await _chatCollection?.doc(chatID).get();

    if(result != null){
      return result.exists;
    }
    return false;
  }

  Future<void> createNewChat(String uid1, String uid2) async{
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);
    final chat = Chat(
        id: chatID,
        participants: [uid1, uid2],
        messages: []
    );
    await docRef.set(chat);
  }

  Future<void> sendChatMessage(String uid1, String uid2, Message message) async{
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);
    await docRef.update(
        {
          "messages": FieldValue.arrayUnion([
            message.toJson()
          ])
        }
    );
  }

  Stream<DocumentSnapshot<Chat>> getChatData(String uid1, String uid2){
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    return _chatCollection?.doc(chatID).snapshots() as Stream<DocumentSnapshot<Chat>> ;
  }
}