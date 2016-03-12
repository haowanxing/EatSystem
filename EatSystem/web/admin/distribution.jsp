<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<% 
    String islogin = null;
    String username = null;
    String usernick = null;
    if(session.getAttribute("aislogin") != null){
        islogin = session.getAttribute("aislogin").toString();
    }
    if(islogin != null && islogin.equals("true"))
    {
        username = session.getAttribute("ausername").toString();
        usernick = session.getAttribute("ausernick").toString();
    }else{
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/docs.min.css" rel="stylesheet">
        <title>人员管理</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <li class="list-group-item"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> 菜单 <a href="DoLogin?act=logout">退出</a></li>
                        <a class="list-group-item btn" href="./index.jsp">总览</a>
                        <a class="list-group-item btn" href="./menu.jsp">菜谱管理</a>
                        <a class="list-group-item btn" href="./distribution.jsp">人员管理</a>
                        <a class="list-group-item btn" href="./profile_order_all.jsp">订单管理</a>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="row page-header">
                        <div class="col-md-4">
                            <ul class="nav nav-tabs">
                                <li role="presentation" class="active"><a href="#">快递人员</a></li>
                                <li role="presentation"><a href="#">室内人员</a></li>
                            </ul>
                        </div>
                        <div class="col-md-2 col-md-offset-6">
                            <ul class="nav nav-stacked">
                                <li role="presentation"><a href="./dis_add.jsp" class="text-success text-center">新增</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>工号</th><th>姓名</th><th>电话</th>
                                    </tr>
    <%
        MysqlController MC = new MysqlController();
        ResultSet rs = MC.getRs("select * from distribution;");
        if(rs.next())
        while(rs.next()){%>
        <tr>
            <td><a href="./dis_info.jsp?disid=<%=rs.getString("disid")%>"><%=rs.getString("disid")%></a></td><td><%=rs.getString("disname")%></td><td><%=rs.getString("disphone")%></td>
        </tr>
        <%}%>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% if (MC != null) MC.Close();%>
        <jsp:include page="../footer.jsp" />
    </body>
</html>
