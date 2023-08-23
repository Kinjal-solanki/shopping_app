part of 'get_shopping_list_bloc.dart';

abstract class GetShoppingListEvent extends Equatable {
  const GetShoppingListEvent();
}

class GetShoppingListInitialFetchEvent extends GetShoppingListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}