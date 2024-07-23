import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final messageControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final chatStreamProvider = StreamProvider.autoDispose((ref) {
  final supabase = ref.watch(supabaseProvider);
  // ignore: deprecated_member_use
  return supabase.from('Chat').stream(primaryKey: ['id']).execute();
});

final sendMessageProvider =
    FutureProvider.family<void, String>((ref, message) async {
  final supabase = ref.watch(supabaseProvider);
  await supabase.from('Chat').insert({"message": message, "is_me": false});
});
