part of 'get_shopping_list_bloc.dart';

abstract class GetShoppingListState extends Equatable {
  const GetShoppingListState();
}

class GetShoppingListInitial extends GetShoppingListState {
  @override
  List<Object> get props => [];
}

abstract class GetShoppingListActionState extends GetShoppingListState {}

class GetShoppingListSuccessState extends GetShoppingListState {
  final List<ShoppingList> shoppingLists;

  GetShoppingListSuccessState({required this.shoppingLists}) {}

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}