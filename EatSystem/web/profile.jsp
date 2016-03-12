<%-- 
    Document   : profile
    Created on : 2015-11-4, 9:50:55
    Author     : 刘经济 <york_mail@qq.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<%
    String islogin = null;
    String username = null;
    String usernick = null;
    if (session.getAttribute("islogin") != null) {
        islogin = session.getAttribute("islogin").toString();
    }
    if (islogin != null && islogin.equals("true")) {
        username = session.getAttribute("username").toString();
        usernick = session.getAttribute("usernick").toString();
    } else {
        request.getRequestDispatcher("error.jsp?error= 你没有登录!&param=  <a href=\"login.jsp\">现在去登录</a>").forward(request, response);
    }
    MysqlController MCer = new MysqlController();
    ResultSet rs;
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/docs.min.css" rel="stylesheet">
        <title>会员中心</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="row">
                <div class="col-md-2 col-xs-10">
                    <div class="list-group">
                        <a class="list-group-item list-group-item-info" href="profile.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> 个人中心</a>
                        <li class="list-group-item"></li>
                        <li class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> 我的订单</li>
                        <a class="list-group-item btn btn-default" href="profile_order_all.jsp">全部订单</a>
                        <a class="list-group-item btn btn-default" href="profile_order_waited.jsp">待评价订单</a>
                        <a class="list-group-item btn btn-default" href="profile_order_canceled.jsp">退单记录</a>
                        <li class="list-group-item"></li>
                        <li class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> 我的资料</li>
                        <a class="list-group-item btn btn-default" href="profile_info.jsp">个人资料</a>
                        <a class="list-group-item btn btn-default" href="profile_info_addr.jsp">地址管理</a>
                        <a class="list-group-item btn btn-default" href="profile_info_pwd.jsp">修改密码</a>
                    </div>
                </div>
                <div class="col-md-offset-0 col-md-10  col-xs-12">
                    <div class="row page-header">
                        <div class="col-xs-4 col-md-2">
                            <div class="thumbnail">
                                <img src="img/pic_0.png" alt="nopic" class="img-rounded" />
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <h4>欢迎您,<strong><%=usernick%></strong></h4>
                            <p class="text-info">订餐了吗？提前订餐送的快哟！</p>
                        </div>
                        <div class="col-sm-3">
                            <% rs = MCer.getRs("select count(*) as sum from orders where cid=\""+ username +"\" and ostat=2; "); 
                            if(rs.next())out.println("<h4>正在配送："+rs.getString("sum")+"</h4>");else{%>
                            <h4>正在配送：无</h4><%}%>
                            <p class="text-info">备注:  </p>
                        </div>
                    </div>
                    <div class="row page-header">
                        <div class="col-md-4">
                            <ul class="nav nav-tabs">
                                <li role="presentation" class="active"><a href="#">最近订单</a></li>
                                <li role="presentation"><a href="profile_order_waited.jsp">待评价订单</a></li>
                            </ul>
                        </div>
                        <div class="col-md-2 col-md-offset-6">
                            <ul class="nav nav-stacked">
                                <li role="presentation"><a href="profile_order_all.jsp" class="text-success">查看全部订单</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>订单号</th><th>餐品名</th><th>价格</th><th>数量</th><th>状态</th>
                                    </tr>
                                    <%
                                        rs = MCer.getRs("select * from orders o left join goods g on o.gid=g.gid where o.cid=\"" + username + "\" order by o.id desc limit 5;");
                                        while (rs.next()) {
                                            String stats = null;
                                            int stat = Integer.parseInt(rs.getString("ostat"));
                                            String tprice = String.format("%.2f",Double.parseDouble(rs.getString("gnum"))*Double.parseDouble(rs.getString("gprice")));
                                    %>
                                    <%
                                        if (stat == 1) {
                                            stats = "创建订单";
                                            out.println("<tr class=\"success\">");
                                        } else if (stat == 2) {
                                            stats = "派送当中";
                                            out.println("<tr class=\"info\">");
                                        } else if (stat == 3) {
                                            stats = "订单完成";
                                            out.println("<tr class=\"warning\">");
                                        } else if (stat == 4) {
                                            stats = "订单取消";
                                            out.println("<tr class=\"danger\">");
                                        } else if (stat == 5) {
                                            stats = "等待评价";
                                            out.println("<tr>");
                                        } else {
                                            stats = "未知";
                                            out.println("<tr>");
                                        }
                                    %>
                                    <td><%=rs.getString("oid")%></td><td><%=rs.getString("gname")%></td><td><%=tprice%></td><td><%=rs.getString("gnum")%></td><td><%=stats%></td>
                                    </tr>
                                    <%}%>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% if (MCer != null) MCer.Close();%>
        <jsp:include page="footer.jsp" />
    </body>
</html>
