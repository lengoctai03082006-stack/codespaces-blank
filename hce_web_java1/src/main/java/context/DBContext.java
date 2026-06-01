package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private final String SERVER = "127.0.0.1";
    private final String PORT = "1433";
    private final String DATABASE = "northwind";

    private final String USER = "sa";
    private final String PASSWORD = "Vietnam@123";

    public Connection getConnection() {

        Connection conn = null;

        try {

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            String url =
                    "jdbc:sqlserver://" + SERVER + ":" + PORT
                    + ";databaseName=" + DATABASE
                    + ";encrypt=true"
                    + ";trustServerCertificate=true";

            conn = DriverManager.getConnection(
                    url,
                    USER,
                    PASSWORD);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return conn;
    }
}