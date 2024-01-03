import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:my_own_proj/models/office_details.model.dart';
import 'package:my_own_proj/store/app.api.dart';
import 'package:my_own_proj/store/app.state.dart';

class IncrementLoaderAction {}

class DecrementLoaderAction {}

class SetOfficesListAction {
  final List<Office> officesList;

  SetOfficesListAction(this.officesList);
}

class SetDatabaseReferenceAction {
  final DatabaseReference reference;

  SetDatabaseReferenceAction(this.reference);
}

class GetDatabaseReferenceAction extends CallableThunkAction<AppState> {
  final bool showLoader;

  GetDatabaseReferenceAction({this.showLoader = true});

  @override
  call(store) async {
    try {
      if (showLoader) store.dispatch(IncrementLoaderAction());

      final DatabaseReference reference = FirebaseDatabase.instance.ref();

      store.dispatch(SetDatabaseReferenceAction(reference));
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      if (showLoader) store.dispatch(DecrementLoaderAction());
    }
  }
}

class GetOfficesListAction extends CallableThunkAction<AppState> {
  final bool showLoader;
  GetOfficesListAction({this.showLoader = true});

  @override
  call(store) async {
    final apiService = AppApi();
    final reference = store.state.reference;

    try {
      if (showLoader) store.dispatch(IncrementLoaderAction());

      final offices = await apiService.fetchDataFromFirebase(reference!);

      store.dispatch(SetOfficesListAction(offices));
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      if (showLoader) store.dispatch(DecrementLoaderAction());
    }
  }
}

class UpdateNewValueAndKeyAction extends CallableThunkAction<AppState> {
  final bool showLoader;
  final String key;
  final dynamic value;
  final int officeIndex;

  UpdateNewValueAndKeyAction({
    this.showLoader = true,
    required this.key,
    required this.value,
    required this.officeIndex,
  });

  @override
  call(Store<AppState> store) async {
    final apiService = AppApi();

    final reference = store.state.reference!;

    try {
      if (showLoader) store.dispatch(IncrementLoaderAction());

      await apiService.updateKeyAndValue(reference, key, value, officeIndex);

      await store.dispatch(GetOfficesListAction());
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      if (showLoader) store.dispatch(DecrementLoaderAction());
    }
  }
}
