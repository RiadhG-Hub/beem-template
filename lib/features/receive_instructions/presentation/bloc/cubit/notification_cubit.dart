import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationState {
  final List<String> notifications;

  NotificationState(this.notifications);
}

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState([]));

  Future<List<String>> loadNotifications(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(key) ?? [];

    emit(NotificationState(items));
    return items;
  }

  Future<void> addNotification(String key, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(key) ?? [];

    if (!existing.contains(id)) {
      existing.add(id);
      await prefs.setStringList(key, existing);
      emit(NotificationState(existing));
    }
  }

  Future<void> clearNotifications(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    emit(NotificationState([]));
  }

  bool contains(String id) {
    return state.notifications.contains(id);
  }
}
