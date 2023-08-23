import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/feature/shopping/Model/ShoppingList.dart';

part 'get_shopping_list_event.dart';
part 'get_shopping_list_state.dart';

class GetShoppingListBloc extends Bloc<GetShoppingListEvent, GetShoppingListState> {
  GetShoppingListBloc() : super(GetShoppingListInitial()) {
    on<GetShoppingListInitialFetchEvent>(getShoppingListInitialFetchEvent);
  }

  Future<void> getShoppingListInitialFetchEvent(GetShoppingListInitialFetchEvent event, Emitter<GetShoppingListState> emit) async {
    var client = http.Client();
    List<ShoppingList> shoppingList;

    try {
      var response = await client
          .get(Uri.parse('https://fakestoreapi.com/products'));
      final List<dynamic> parsedJson = json.decode(response.body);
      shoppingList = parsedJson.map((jsonItem) => ShoppingList.fromJson(jsonItem)).toList();
      emit(GetShoppingListSuccessState(shoppingLists: shoppingList));
    } catch(e){
      debugPrint(e.toString());
    }
  }
}
