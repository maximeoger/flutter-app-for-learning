// Database
const dbName = 'notes.db';

// Tabmes
const noteTable = 'note';
const userTable = 'user';

// Columns
const idColumn = "id";
const emailColumn = "email";
const userIdColumn = "user_id";
const textColumn = "text";
const timestampColumn = "timestamp";
const isSyncedWithCloudColumn = "is_synced_with_cloud";

// SQL
const createUserTable = '''
        CREATE TABLE IF NOT EXISTS "User" (
          "id"	INTEGER NOT NULL,
          "email"	TEXT NOT NULL,
          PRIMARY KEY("id" AUTOINCREMENT)
        );
      ''';

const createNoteTable = '''
        CREATE TABLE IF NOT EXISTS "Note" (
          "id"	INTEGER NOT NULL,
          "user_id"	INTEGER,
          "text"	TEXT,
          "timestamp"	TEXT,
          "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
          FOREIGN KEY("user_id") REFERENCES "User"("id"),
          PRIMARY KEY("id" AUTOINCREMENT)
        );
      ''';

const deleteDb = '''
  DROP DATABASE notes.db;
''';
