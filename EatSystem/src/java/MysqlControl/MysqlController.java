/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MysqlControl;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.*;
import javax.sql.*;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
public class MysqlController {

    private Connection con = null;
    private ResultSet rs;
    private Statement stmt;

    public MysqlController() {
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource) initCtx.lookup("jdbc/test");
            if (ds != null) {
                con = ds.getConnection();
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    public Connection getCon() {
        return con;
    }

    public ResultSet getRs(String sql) throws Exception {
        try {
            stmt = con.createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public int executeUpdate(String sql) {
        int count = 0;
        try {
            stmt = con
                    .createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                            ResultSet.CONCUR_UPDATABLE);
            count = stmt.executeUpdate(sql);
            if (count != 0)
                ; // con.commit();
            else
                ;
            // con.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally{
            if(stmt!=null){
                try {
                    stmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MysqlController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return count;
    }

    public void Close() {
        try {
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
