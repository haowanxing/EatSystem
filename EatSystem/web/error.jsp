<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>错误页面</title>
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
                    <h1 class="text-center">发生错误!错误原因:<% if(request.getParameter("error")!=null){%><span class="text-danger"><%=request.getParameter("error")%></span><%}else{%><span class="danger">未知!</span><%}%><small class="text-info">&nbsp;&nbsp;&nbsp;&nbsp;<% if(request.getParameter("param")!=null){%><%=request.getParameter("param")%><%}%></small></h1>
                </div>
            </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
