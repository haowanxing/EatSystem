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
        <title>退单记录</title>
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
                        <a class="list-group-item btn btn-default" href="profile_order_all.jsp">全部订单</a>
                        <a class="list-group-item btn btn-default" href="profile_order_waited.jsp">待评价订单</a>
                        <a class="list-group-item btn btn-default active" href="profile_order_canceled.jsp">退单记录</a>
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
                                <div class="col-md-4 col-xs-6">
                                    <ul class="nav nav-tabs">
                                        <li role="presentation" class="active"><a href="#">已取消订单</a></li>
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
                                                <th>订单号</th><th>餐品名</th><th>价格</th><th>数量</th><th>操作</th>
                                            </tr>
                                            <%
                                                MysqlController MCer = new MysqlController();
                                                ResultSet rs = MCer.getRs("select * from orders o left join goods g on o.gid=g.gid where o.cid=\"" + username + "\" and o.ostat=4 order by o.id desc;");
                                                while (rs.next()) {
                                                    double tprice = Double.parseDouble(rs.getString("gnum"))*Double.parseDouble(rs.getString("gprice"));
                                            %>
                                            <tr>
                                                <td><%=rs.getString("oid")%></td><td><%=rs.getString("gname")%></td><td><%=tprice%></td><td><%=rs.getString("gnum")%>份</td><td><a href="buy.jsp?good=<%=rs.getString("gid")%>">再次购买</a></td>
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
