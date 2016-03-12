<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<% 
    String islogin = null;
    String username = null;
    String usernick = null;
    if(session.getAttribute("islogin") != null){
        islogin = session.getAttribute("islogin").toString();
    }
    if(islogin != null && islogin.equals("true"))
    {
        username = session.getAttribute("username").toString();
        usernick = session.getAttribute("usernick").toString();
    }else{
        request.getRequestDispatcher("error.jsp?error= 你没有登录!&param=  <a href=\"login.jsp\">现在去登录</a>").forward(request, response);
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/docs.min.css" rel="stylesheet">
        <title>全部订单</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <div class="row">
                <div class="col-md-2  col-xs-12">
                    <div class="list-group">
                        <a class="list-group-item list-group-item-info" href="profile.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> 个人中心</a>
                        <li class="list-group-item"></li>
                        <li class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> 我的订单</li>
                        <a class="list-group-item btn btn-default active" href="profile_order_all.jsp">全部订单</a>
                        <a class="list-group-item btn btn-default" href="profile_order_waited.jsp">待评价订单</a>
                        <a class="list-group-item btn btn-default" href="profile_order_canceled.jsp">退单记录</a>
                        <li class="list-group-item"></li>
                        <li class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> 我的资料</li>
                        <a class="list-group-item btn btn-default" href="profile_info.jsp">个人资料</a>
                        <a class="list-group-item btn btn-default" href="profile_info_addr.jsp">地址管理</a>
                        <a class="list-group-item btn btn-default" href="profile_info_pwd.jsp">修改密码</a>
                    </div>
                </div>
                <div class="col-md-10  col-xs-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">我的订单</div>
                        <div class="panel-body">
                            <div class="row page-header">
                                <div class="col-md-4">
                                    <ul class="nav nav-tabs">
                                        <li role="presentation" class="active"><a href="#">全部订单</a></li>
                                        <li role="presentation"><a href="profile_order_waited.jsp">待评价订单</a></li>
                                    </ul>
                                </div>
                                <div class="row center-block">
                                    <div class="col-sm-offset-0 col-sm-12">
                                        <table class="table table-striped table-bordered">
                                            <tr>
                                                <th>订单号</th><th>餐品名</th><th>价格</th><th>数量</th><th>状态</th>
                                            </tr>
                                            <%
                                                MysqlController MCer = new MysqlController();
                                                ResultSet rs = MCer.getRs("select * from orders o left join goods g on o.gid=g.gid where o.cid=\"" + username + "\" order by o.id desc;");
                                                while (rs.next()) {
                                                    String stats = null;
                                                    int stat = Integer.parseInt(rs.getString("ostat"));
                                                    String tprice = String.format("%.2f",Double.parseDouble(rs.getString("gnum"))*Double.parseDouble(rs.getString("gprice")));
                                            
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
                                            <td><a href="./order_info.jsp?oid=<%=rs.getString("oid")%>"><%=rs.getString("oid")%></a></td><td><a href="./buy.jsp?good=<%=rs.getString("gid")%>"><%=rs.getString("gname")%></a></td><td><%=tprice%></td><td><%=rs.getString("gnum")%></td><td><%=stats%></td>
                                            </tr>
                                            <%}%>
                                        </table>
                                    </div>
                                </div>
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
