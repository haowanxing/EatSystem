<%-- 
    Document   : user-home
    Created on : 2015-11-3, 20:24:37
    Author     : 刘经济 <york_mail@qq.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/docs.min.css" rel="stylesheet">
        <title>购买单品</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="row">
                <%
                    String gid = "";
                    if (request.getParameter("good") != null) {
                        gid = request.getParameter("good");
                    } else {
                        request.getRequestDispatcher("error.jsp?error= 错误的请求!").forward(request, response);
                        return;
                    }
                    MysqlController MCer = new MysqlController();
                    ResultSet rs = MCer.getRs("select * from goods where gid=\"" + gid + "\";");
                    while (rs.next()) {
                %>
                <form action="Good" method="post" accept-charset="utf-8">
                    <input name="act" value="order" type="hidden"/>
                    <input name="gid" value="<%=rs.getString("gid")%>" type="hidden"/>
                    <input name="useraddr" value="<%=session.getAttribute("useraddr")%>" type="hidden"/>
                <div class="col-md-3 col-md-offset-1">
                    <div class="row">
                        <div class="thumbnail">
                            <img src="<%=rs.getString("gpic")%>" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-md-offset-1">
                    <div class="row">
                        <h4><strong><%=rs.getString("gname")%></strong></h4>
                        <h5 class="text-danger"><%=rs.getString("gdesc")%></h5>
                    </div>
                    <div class="row">
                        <div class="input-group input-group-sm col-md-3">
                            <span class="input-group-addon">价格:</span>
                            <span class="input-group-addon text-info">￥<%=rs.getString("gprice")%></span>
                        </div><br/>
                        <div class="input-group input-group-sm col-md-3">
                            <span class="input-group-addon" id="goodnum">购买数量:</span>
                            <input class="form-control" type="text" name="goodnum" value="1"/>
                            <span class="input-group-addon">份</span>
                        </div>
                    </div>
                    <div class="row">
                        <button class="btn btn-success" style="margin-top: 40px" type="submit">马上下单!</button>
                    </div>
                </div>
                </form>
                <% } %>
            </div>
        </div>
        <% if (MCer != null) MCer.Close(); %>
        <jsp:include page="footer.jsp" />
    </body>
</html>
