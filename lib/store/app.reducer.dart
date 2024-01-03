import 'package:my_own_proj/store/app.actions.dart';
import 'package:my_own_proj/store/app.state.dart';

AppState appReducer(AppState state, action) {
  if (action is SetOfficesListAction) {
    return state.copyWith(officesList: action.officesList);
  } else if (action is SetDatabaseReferenceAction) {
    return state.copyWith(reference: action.reference);
  } else if (action is IncrementLoaderAction) {
    return state.copyWith(loaderCount: 1);
  } else if (action is DecrementLoaderAction) {
    return state.copyWith(loaderCount: 0);
  } else {
    return state;
  }
}
