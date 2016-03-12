<%-- 
    Document   : index
    Created on : 2015-11-25, 19:11:00
    Author     : 刘经济 <york_mail@qq.com>
--%>

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
        return;
    }
    MysqlController MC = new MysqlController();
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/docs.min.css" rel="stylesheet">
        <title>管理中心</title>
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
                        <%ResultSet rs1 = MC.getRs("select count(*) from orders");
                        String allordernum="无",sending="无",sendin="无";
                        while(rs1.next()){
                            allordernum = rs1.getString("count(*)");
                        }
                        rs1.close();
                        rs1 = MC.getRs("select count(*) from orders where ostat=\"2\"");
                        while(rs1.next()){
                            sending = rs1.getString("count(*)");
                        }
                        rs1.close();
                        rs1 = MC.getRs("select count(*) from orders where ostat=\"1\"");
                        while(rs1.next()){
                            sendin = rs1.getString("count(*)");
                        }
                        %>
                        <div class="col-sm-3">
                            <h5>总订单数：<%=allordernum%></h5>
                        </div>
                        <div class="col-sm-3">
                            <h5>正在配送：<%=sending%></h5>
                        </div>
                        <div class="col-sm-3">
                            <h5>等待配送：<%=sendin%></h5>
                        </div>
                    </div>
                    <div class="row page-header">
                        <div class="col-md-4">
                            <ul class="nav nav-tabs">
                                <li role="presentation" class="active"><a href="#">最近订单</a></li>
                                <li role="presentation"><a href="#">待评价订单</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>订单号</th><th>餐品名</th><th>价格</th><th>数量</th><th>状态</th><th>用户</th>
                                    </tr>
                                    <%
                                        ResultSet rs = MC.getRs("select * from orders o left join goods g on o.gid=g.gid order by o.id desc limit 10;");
                                        while(rs.next()){
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
                                    <td><a href="./order_info.jsp?oid=<%=rs.getString("oid")%>"><%=rs.getString("oid")%></a></td><td><%=rs.getString("gname")%></td><td><%=tprice%></td><td><%=rs.getString("gnum")%></td><td><%=stats%></td><td><%=rs.getString("cid")%></td>
                                    </tr>
                                    <%}
                                    MC.Close();%>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../footer.jsp" />
    </body>
</html>
