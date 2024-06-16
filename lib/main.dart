import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_state/example2/weather_provider.dart';
import 'package:riverpod_state/example3/rpod_stream.dart';

void main() {
  runApp(const ProviderScope(child: StreamApp()));
}
