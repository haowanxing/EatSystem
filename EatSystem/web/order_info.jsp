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
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    String oid = request.getParameter("oid");
    if (oid == null) {
        request.getRequestDispatcher("./profile_order_all.jsp").forward(request, response);
        return;
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
        <title>订单详情</title>
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
                                        <li role="presentation"><a href="./profile_order_all.jsp">全部订单</a></li>
                                        <li role="presentation" class="active"><a href="#">当前:</a></li>
                                    </ul>
                                </div>
                                <div class="row center-block">
                                    <div class="col-sm-offset-0 col-sm-12">
                                        <%
                                            MysqlController MC = new MysqlController();
                                            ResultSet rs = MC.getRs("select * from orders o left join goods g on o.gid=g.gid where oid=\"" + oid + "\" order by o.id desc");
                                            while (rs.next()) {
                                                String tprice = String.format("%.2f", Double.parseDouble(rs.getString("gnum")) * Double.parseDouble(rs.getString("gprice")));
                                        %>
                                        <form id="form1" action="../OrderUpdate" method="POST">
                                            <input type="hidden" name="from" value="gm"/>
                                            <div class="form-group">
                                                <label for="goodoid" class="col-md-2 control-label">订单号：</label>
                                                <div class="col-md-10">
                                                    <input type="text" name="goodoid" class="form-control" id="goodoid" readonly value="<%=rs.getString("oid")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="goodname" class="col-md-2 control-label">商品名：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="goodname" class="form-control" id="goodname" readonly value="<%=rs.getString("gname")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="username" class="col-md-2 control-label">买家姓名：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="username" class="form-control" id="username" readonly value="<%=rs.getString("cname")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userid" class="col-md-2 control-label">买家ID：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="userid" class="form-control" id="userid" readonly value="<%=rs.getString("cid")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="phone" class="col-md-2 control-label">联系方式：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="phone" class="form-control" id="phone" readonly value="<%=rs.getString("cphone")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="caddr" class="col-md-2 control-label">地址：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="caddr" class="form-control" id="caddr" readonly value="<%=rs.getString("cadr")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="totalprice" class="col-md-2 control-label">总价格：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="totalprice" class="form-control" id="totalprice" readonly value="<%=tprice%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="num" class="col-md-2 control-label">数量：</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="num" class="form-control" id="num" readonly value="<%=rs.getString("gnum")%>">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="stats" class="col-md-2 control-label">当前状态：</label>
                                                <div class="col-md-4">
                                                    <% String[] sta = {"0", "创建订单", "派送当中", "订单完成", "订单取消", "待评价"};%>
                                                    <input type="text" name="ostat" class="form-control" id="stats" readonly value="<%=sta[Integer.parseInt(rs.getString("ostat"))]%>"/>
                                                </div>
                                            </div>
                                        </form>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% if (MC != null) {
                MC.Close();
            }%>
    <jsp:include page="./footer.jsp" />
</body>
</html>
