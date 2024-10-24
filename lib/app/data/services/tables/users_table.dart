import 'package:sqflite/sqflite.dart';

const tblUsers = 'users';

Future<void> usersTable(Database db) async {
  return db.execute(
    '''
      CREATE TABLE $tblUsers
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT DEFAULT 'guest' NOT NULL,
        displayName TEXT NOT NULL
      )
      ''',
  );
}
