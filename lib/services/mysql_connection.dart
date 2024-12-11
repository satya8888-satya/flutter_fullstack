import 'package:mysql1/mysql1.dart';

class MysqlConnection {
  // Connection settings
  static final String host =
      'your_mysql_host'; // e.g., 'localhost' or 'myhostingofmysql.com'
  static final int port = 3306; // Default MySQL port
  static final String user = 'root'; // Your MySQL username
  static final String password = 'root'; // Your MySQL password
  static final String db = 'flutter_fullstack'; // Your database name

  // Method to get a connection to the database
  static Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );

    return await MySqlConnection.connect(settings);
  }

  // Example method to fetch users from the database
  static Future<List<Map<String, dynamic>>> fetchUsers() async {
    var conn = await getConnection();
    try {
      var results = await conn.query('SELECT * FROM users');
      List<Map<String, dynamic>> users = [];
      for (var row in results) {
        users.add({
          'id': row[0],
          'email': row[1],
          'role': row[2],
        });
      }
      return users;
    } finally {
      await conn.close(); // Always close the connection
    }
  }

  // Example method to insert a new user into the database
  static Future<void> insertUser(String email, String password) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'INSERT INTO users (email, password) VALUES (?, ?)',
        [email, password],
      );
    } finally {
      await conn.close(); // Always close the connection
    }
  }

  // Example method to update a user's password
  static Future<void> updateUserPassword(int id, String newPassword) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'UPDATE users SET password = ? WHERE id = ?',
        [newPassword, id],
      );
    } finally {
      await conn.close(); // Always close the connection
    }
  }

  // Example method to delete a user from the database
  static Future<void> deleteUser(int id) async {
    var conn = await getConnection();
    try {
      await conn.query(
        'DELETE FROM users WHERE id = ?',
        [id],
      );
    } finally {
      await conn.close(); // Always close the connection
    }
  }
}
