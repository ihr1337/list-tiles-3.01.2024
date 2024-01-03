import 'package:flutter/material.dart';

import 'package:my_own_proj/common/capitalize_string.dart';
import 'package:my_own_proj/models/office_details.model.dart';

class HomePage extends StatelessWidget {
  final String title;
  final List<Office> officesList;

  final VoidCallback downloadOffices;

  final Function(Office officeDetails, int officeIndex) onCardTap;

  const HomePage({
    super.key,
    required this.title,
    required this.officesList,
    required this.onCardTap,
    required this.downloadOffices,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: downloadOffices,
            icon: const Icon(Icons.replay_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < officesList.length; i++)
              ListTile(
                leading: Image.network(officesList[i].image),
                title: Text(officesList[i].id.capitalize()),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => onCardTap(
                  officesList[i],
                  i,
                ),
              )
          ],
        ),
      ),
    );
  }
}
