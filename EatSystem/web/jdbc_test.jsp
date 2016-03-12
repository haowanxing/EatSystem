<%-- 
    Document   : jdbc_test
    Created on : 2015-11-8, 13:24:37
    Author     : 刘经济 <york_mail@qq.com>
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>测试GlassFish配置的Mysql数据库连接池</title>
    </head>
    <body>
        <h1>下面是测试结果：</h1>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            ResultSetMetaData md = null;
            try {
                Context initCtx = new InitialContext();
                DataSource ds = (DataSource) initCtx.lookup("jdbc/test");
                if (ds != null) {
                    out.println("已经获得DataSource连接<br>");
                    out.println("资源ID: " + ds.toString() + "<br>");
                    conn = ds.getConnection();
                    stmt = conn.createStatement();
                    out.println("从DataSource获取Connection成功!<p>");
                    rs = stmt.executeQuery("select * from admins");
                    md = rs.getMetaData();
                    out.println("<table border=1 width=80%  align=center bgcolor=#ffdddd>");
                    out.println("<tr>");
                    for (int i = 0; i < md.getColumnCount(); i++) {
                        out.println("<td>" + md.getColumnName(i + 1) + "</td>");
                    }
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString(1) + "</td>");
                        out.println("<td>" + rs.getString(2) + "</td>");
                        out.println("<td>" + rs.getString(3) + "</td>");
                        out.println("<td>" + rs.getString(4) + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    conn.close();
                    out.println("<p>关闭连接..</p>");
                }
            } catch (Exception e) {
                out.println("<p>出现异常..</p>");
                out.println(e.toString());
            }
        %>
    </body>
</html>