<%-- 
    Document   : index.jsp
    Created on : 2015-11-3, 20:17:39
    Author     : 刘经济 <york_mail@qq.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>反馈信息</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/docs.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <h1 class="text-center">提示:<% if(request.getParameter("text")!=null){%><span class="text-danger"><%=request.getParameter("text")%></span><%}else{%><span class="danger">未知!</span><%}%><small class="text-info">&nbsp;&nbsp;&nbsp;&nbsp;<% if(request.getParameter("param")!=null)%><%=request.getParameter("param")%></small></h1>
                </div>
            </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
