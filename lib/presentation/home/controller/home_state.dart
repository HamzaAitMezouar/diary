import 'package:diary/data/datasource/aricles/article_model.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {} // Default state

class HomeLoaded extends HomeState {
  final List<ArticleModel> articles;

  HomeLoaded({required this.articles});
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
