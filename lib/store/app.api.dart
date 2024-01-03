import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:my_own_proj/models/office_details.model.dart';

class AppApi {
  Future<List<Office>> fetchDataFromFirebase(
      DatabaseReference databaseReference) async {
    DataSnapshot snapshot = await databaseReference.child('offices').get();

    List<Office> offices = [];

    if (snapshot.value != null) {
      try {
        final List<Object?> data = snapshot.value as List<Object?>;

        for (var item in data) {
          if (item is Map<dynamic, dynamic>) {
            offices.add(Office(
              address: item['address'] ?? '',
              image: item['image'] ?? '',
              id: item['id'] ?? '',
              lng: item['lng'] ?? 0,
              lat: item['lat'] ?? 0,
            ));
          } else {
            debugPrint('Item isn\'t Map<dynamic,dynamic>');
          }
        }
      } catch (e) {
        debugPrint("Error parsing data: $e");
      }
    }
    return offices;
  }

  Future<void> updateKeyAndValue(DatabaseReference reference, String key,
      dynamic value, int officeIndex) async {
    await reference.child('offices/$officeIndex').update({
      key: value,
    });
  }
}
