import 'package:firebase_database/firebase_database.dart';
import 'package:my_own_proj/models/office_details.model.dart';

class AppState {
  final int loaderCount;
  final List<Office> officesList;
  final DatabaseReference? reference;

  const AppState({
    required this.loaderCount,
    required this.officesList,
    required this.reference,
  });

  AppState.initialState()
      : loaderCount = 0,
        officesList = [],
        reference = null;

  AppState copyWith({
    int? loaderCount,
    List<Office>? officesList,
    DatabaseReference? reference,
  }) {
    return AppState(
      loaderCount: loaderCount ?? this.loaderCount,
      officesList: officesList ?? this.officesList,
      reference: reference ?? this.reference,
    );
  }
}
