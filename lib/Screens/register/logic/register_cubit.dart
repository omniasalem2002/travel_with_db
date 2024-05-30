import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guru/Screens/register/logic/register_state.dart';
import 'package:guru/Screens/register/models/AddUserRequest.dart';
import 'package:guru/Screens/register/models/AddUserResponse.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitial());
  TextEditingController tourGuideNameController = TextEditingController();
  TextEditingController tourGuideEmailController = TextEditingController();

  Future<void> addUserToFireStore() async {
    emit(AddUserLoading());

    try {
      var collectionRef = FirebaseFirestore.instance.collection('tour_guides');
      DocumentReference docRef = await collectionRef.add({
        'name': tourGuideNameController.text,
        'email': tourGuideEmailController.text
      });

      // Assuming AddUserResponse takes a document ID and user data
      AddUserResponse response = AddUserResponse(

        documentId: docRef.id,
        name: tourGuideNameController.text,
        email: tourGuideEmailController.text,
      );

      emit(AddUserSuccess(response: response));
    } catch (e) {
      emit(AddUserFailure(error: e.toString()));
    }
  }
}