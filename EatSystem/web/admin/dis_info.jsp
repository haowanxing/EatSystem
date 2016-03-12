<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<%
    String islogin = null;
    String username = null;
    String usernick = null;
    if (session.getAttribute("aislogin") != null) {
        islogin = session.getAttribute("aislogin").toString();
    }
    if (islogin != null && islogin.equals("true")) {
        username = session.getAttribute("ausername").toString();
        usernick = session.getAttribute("ausernick").toString();
    } else {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    String disid = request.getParameter("disid");
    if (disid == null) {
        request.getRequestDispatcher("./distribution.jsp").forward(request, response);
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
        <title>员工信息</title>
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
                                <li role="presentation" class="active"><a href="#">员工信息:</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <%
                                MysqlController MC = new MysqlController();
                                ResultSet rs = MC.getRs("select * from distribution where disid=\""+disid+"\"");
                                while(rs.next()){
                                %>
                                <form id="form1" action="../DisEdit" method="POST">
                                    <input type="hidden" name="act" value="edit"/>
                                <div class="form-group">
                                    <label for="disid" class="col-md-2 control-label">员工工号：</label>
                                    <div class="col-md-4">
                                        <input type="hidden" name="dis" value="<%=rs.getString("disid")%>"/>
                                        <input type="text" name="disid" class="form-control" id="disid" value="<%=rs.getString("disid")%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="disname" class="col-md-2 control-label">姓名：</label>
                                    <div class="col-md-4">
                                        <input type="text" name="disname" class="form-control" id="disname" value="<%=rs.getString("disname")%>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="dispwd" class="col-md-2 control-label">密码:</label>
                                    <div class="col-md-4">
                                        <input type="password" name="dispwd" class="form-control" id="dispwd" placeholder="无需修改请留空" value=""/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="disphone" class="col-md-2 control-label">手机号码：</label>
                                    <div class="col-md-4">
                                        <input type="text" name="disphone" class="form-control" id="disphone" value="<%=rs.getString("disphone")%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-offset-9 col-md-3">
                                        <button type="button" onclick="subform()" class="btn btn-primary">修改</button>
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
        <% if (MC != null) MC.Close();%>
        <jsp:include page="../footer.jsp" />
        <script>
            function subform(){
                $.post($("#form1").attr("action"), $("#form1").serialize(),function(data){
                    if(data == 1){
                        alert("变更成功!");
                        window.location.href = "./distribution.jsp";
                    }else{
                        alert("信息有误或填写不正确,操作失败 err:"+data);
                    }
                });
            }
        </script>
    </body>
</html>
