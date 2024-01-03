import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:my_own_proj/models/office_details.model.dart';
import 'package:my_own_proj/pages/home/home.page.dart';
import 'package:my_own_proj/store/app.actions.dart';
import 'package:my_own_proj/store/app.state.dart';
import 'package:my_own_proj/widgets/card_details.modal.dart';
import 'package:my_own_proj/widgets/loader.widget.dart';

class HomeContainer extends StatelessWidget {
  final String title;

  const HomeContainer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) async {
        await store.dispatch(GetDatabaseReferenceAction());
      },
      converter: (store) => _ViewModel.create(store, context),
      builder: (context, vm) {
        return LoaderWidget(
          child: HomePage(
            title: title,
            officesList: vm.officesList ?? [],
            onCardTap: vm.onCardTap,
            downloadOffices: vm.downloadOffices,
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<Office>? officesList;

  final VoidCallback downloadOffices;

  final Function(Office officeDetails, int officeIndex) onCardTap;

  _ViewModel({
    required this.officesList,
    required this.downloadOffices,
    required this.onCardTap,
  });

  factory _ViewModel.create(Store<AppState> store, BuildContext context) {
    void onEditOfficeInfo(
      String key,
      dynamic value,
      int officeIndex,
    ) async {
      await store.dispatch(
        UpdateNewValueAndKeyAction(
          key: key,
          value: value,
          officeIndex: officeIndex,
        ),
      );
    }

    void onCardTap(Office officeDetails, int officeIndex) {
      showModalBottomSheet(
        context: context,
        builder: (context) => CardDetailsPage(
          officeDetails: officeDetails,
          onAddressEditApply: onEditOfficeInfo,
          onIdEditApply: onEditOfficeInfo,
          onLngEditApply: onEditOfficeInfo,
          onLatEditApply: onEditOfficeInfo,
          officeIndex: officeIndex,
        ),
      );
    }

    void onGetOfficesTap() async {
      await store.dispatch(GetOfficesListAction());
    }

    return _ViewModel(
      officesList: store.state.officesList,
      downloadOffices: onGetOfficesTap,
      onCardTap: onCardTap,
    );
  }
}
