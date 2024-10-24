import 'package:sqflite/sqflite.dart';

const tblProducts = 'products';

Future<void> productsTable(Database db) async {
  return await db.execute(
    '''
      CREATE TABLE $tblProducts
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productCategory TEXT NOT NULL,
        name TEXT NOT NULL UNIQUE,
        brand TEXT,
        description TEXT NOT NULL,
        basePrice INT NOT NULL,
        inStock BOOLEAN NOT NULL,
        stock INT NOT NULL,
        featuredImage TEXT,
        thumbnailImage TEXT,
        storageOptions TEXT,
        colorOptions TEXT,
        display TEXT,
        CPU TEXT,
        GPU TEXT,
        camera JSON
      )
      ''',
  );
}
