/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package JDBCConn;

import java.sql.*;


/**
 *
 * @author Sayan
 */
public class DatabaseConnection {

public Connection DataConn(){
    String savepath="",datapass="abcdefgh";
    String driver = "com.mysql.jdbc.Driver";
    Connection connect=null;
    try{

        Class.forName(driver);
        String url = "jdbc:mysql://localhost:3306/testdata";
        String user = "root";
        String pw = datapass;
        connect = DriverManager.getConnection( url, user, pw );
        }
        catch(ClassNotFoundException | SQLException ex)
        {
            System.out.println(ex.toString());
        }

          return connect;
    }

}
