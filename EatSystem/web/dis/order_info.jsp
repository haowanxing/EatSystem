<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<%
    String islogin = null;
    String username = null;
    String usernick = null;
    if (session.getAttribute("dislogin") != null) {
        islogin = session.getAttribute("dislogin").toString();
    }
    if (islogin != null && islogin.equals("true")) {
        username = session.getAttribute("dusername").toString();
        usernick = session.getAttribute("dusernick").toString();
    } else {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    String oid = request.getParameter("oid");
    if (oid == null) {
        request.getRequestDispatcher("./index.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../css/docs.min.css" rel="stylesheet">
        <title>订单详情</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <li class="list-group-item"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> 菜单 <a href="DoLogin?act=logout">退出</a></li>
                        <a class="list-group-item btn" href="./index.jsp">订单管理</a>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="row page-header">
                        <div class="col-md-4">
                            <ul class="nav nav-tabs">
                                <li role="presentation" class="active"><a href="#">当前:</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <%
                                MysqlController MC = new MysqlController();
                                ResultSet rs = MC.getRs("select * from orders o left join goods g on o.gid=g.gid where oid=\""+oid+"\" order by o.id desc");
                                while(rs.next()){
                                    String tprice = String.format("%.2f",Double.parseDouble(rs.getString("gnum"))*Double.parseDouble(rs.getString("gprice")));
                                %>
                                <form id="form1" action="../OrderUpdate" method="POST">
                                    <input type="hidden" name="from" value="dis"/>
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
                                        <input type="text" name="caddr" class="form-control" id="caddr" value="<%=rs.getString("cadr")%>">
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
                                        <input type="text" name="num" class="form-control" id="num" value="<%=rs.getString("gnum")%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="stats" class="col-md-2 control-label">当前状态：</label>
                                    <div class="col-md-4">
                                        <select name="ostats" class="form-control">
                                            <% String[] sta = {"创建订单","派送当中","订单完成","订单取消","待评价"};
                                            for(int i=0;i<3;i++){
                                                if(i+1 == Integer.parseInt(rs.getString("ostat"))){%>
                                            <option value="<%=i+1%>" selected="selected"><%=sta[i]%></option>
                                            <%}else{%>
                                            <option value="<%=i+1%>"><%=sta[i]%></option>
                                                    <%}}%>
                                        </select>
                                    </div>
                                </div>
                                        <input type="hidden" name="disid" value="<%=username%>" />
                                <div class="form-group">
                                    <div class="col-md-offset-9 col-md-3">
                                        <button type="button" onclick="subform()" class="btn btn-primary">修改</button>
                                    </div>
                                </div>
                                </form>
                                <%}
                                MC.Close();%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% if (MC != null) MC.Close();%>
        <jsp:include page="../footer.jsp" />
        <script>
            function subform(){
                $.post($("#form1").attr("action"), $("#form1").serialize(),function(data){
                    if(data == 1){
                        alert("变更成功!");
                        window.location.href = "./";
                    }
                });
            }
        </script>
    </body>
</html>
