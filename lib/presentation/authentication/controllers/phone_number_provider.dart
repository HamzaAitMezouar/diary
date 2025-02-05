import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Create a provider to store the phone number state
final phoneNumberProvider = StateProvider<PhoneNumber>((ref) => PhoneNumber());
