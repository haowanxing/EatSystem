<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>首页</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/docs.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                <%
                    MysqlController MCer = new MysqlController();
                    ResultSet rs = MCer.getRs("select * from goods;");
                    while(rs.next()){
                %>
                    <div class="col-sm-5 col-md-3">
                        <div class="thumbnail">
                            <img src="<%=rs.getString("gpic")%>" alt="...">
                            <div class="caption">
                                <h3><%=rs.getString("gname")%><small>   ￥<%=rs.getString("gprice")%>元</small></h3>
<!--                                <p>已售出:45份</p> -->
                                <p><%=rs.getString("gdesc")%></p>
                                <p><a href="#<%=rs.getString("gid")%>" class="btn btn-success" role="button">加入购物车</a> <a href="buy.jsp?good=<%=rs.getString("gid")%>" class="btn btn-default" role="button">单买</a></p>
                            </div>
                        </div>
                    </div>
                <% } %>
                </div>
            </div>
                <% if(MCer!=null)  MCer.Close(); %>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
