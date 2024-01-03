import 'package:flutter/material.dart';

import 'package:my_own_proj/models/office_details.model.dart';
import 'package:my_own_proj/widgets/textfield_with_button.widget.dart';

class CardDetailsPage extends StatelessWidget {
  final Office officeDetails;
  final int officeIndex;

  final Function(
    String key,
    dynamic value,
    int officeIndex,
  ) onAddressEditApply;

  final Function(
    String key,
    dynamic value,
    int officeIndex,
  ) onIdEditApply;

  final Function(
    String key,
    dynamic value,
    int officeIndex,
  ) onLngEditApply;

  final Function(
    String key,
    dynamic value,
    int officeIndex,
  ) onLatEditApply;

  const CardDetailsPage({
    super.key,
    required this.officeDetails,
    required this.onAddressEditApply,
    required this.onIdEditApply,
    required this.onLngEditApply,
    required this.onLatEditApply,
    required this.officeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              officeDetails.image,
              height: 150,
              width: 200,
            ),
            TextfieldWithButton(
              textFieldValue: officeDetails.address,
              onTap: onAddressEditApply,
              itemKey: 'address',
              officeIndex: officeIndex,
            ),
            TextfieldWithButton(
              textFieldValue: officeDetails.id,
              onTap: onIdEditApply,
              itemKey: 'id',
              officeIndex: officeIndex,
            ),
            TextfieldWithButton(
              textFieldValue: officeDetails.lng.toString(),
              onTap: onLngEditApply,
              itemKey: 'lng',
              officeIndex: officeIndex,
            ),
            TextfieldWithButton(
              textFieldValue: officeDetails.lat.toString(),
              onTap: onLatEditApply,
              itemKey: 'lat',
              officeIndex: officeIndex,
            ),
          ],
        ),
      ),
    );
  }
}
