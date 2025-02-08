import 'package:diary/data/models/user_model.dart';
import 'package:diary/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {} // Default state

class SocialMediaLoading extends AuthState {
  final SocialMediaProvider provider;

  SocialMediaLoading({required this.provider});
}

class LogoutLoadingLoading extends AuthState {}

class PhoneAuthLoading extends AuthState {}

class SendOtpSuccess extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;

  Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class Unauthenticated extends AuthState {}
