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
    String gid = request.getParameter("gid");
    if (gid == null) {
        request.getRequestDispatcher("./menu.jsp").forward(request, response);
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
        <title>商品信息</title>
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
                                <li role="presentation" class="active"><a href="#">商品信息</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <%
                                MysqlController MC = new MysqlController();
                                ResultSet rs = MC.getRs("select * from goods where gid=\""+gid+"\"");
                                while(rs.next()){
                                %>
                                <form action="./GoodEdit" method="POST" ENCTYPE="multipart/form-data">
                                <div class="form-group">
                                    <label for="gid" class="col-md-2 control-label">编号：</label>
                                    <div class="col-md-10">
                                        <input type="text" name="gid" readonly class="form-control" id="gid" value="<%=rs.getString("gid")%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="gname" class="col-md-2 control-label">名称：</label>
                                    <div class="col-md-10">
                                        <input type="text" name="gname" class="form-control" id="gname" value="<%=rs.getString("gname")%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="gdesc" class="col-md-2 control-label">描述：</label>
                                    <div class="col-md-10">
                                        <textarea name="gdesc" cols="20" rows="5" class="form-control" id="gdesc"><%=rs.getString("gdesc")%></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="gpic" class="col-md-2 control-label">图片：</label>
                                    <div class="col-md-6">
                                        <input type="file" name="gpic" class="form-control" id="gpic">
                                    </div>
                                    <div class="col-md-4">
                                        <img width="200" height="200" src="../<%=rs.getString("gpic")%>"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="gprice" class="col-md-2 control-label">单价(元)：</label>
                                    <div class="col-md-10">
                                        <input type="text" name="gprice" class="form-control" id="gprice" value="<%=rs.getString("gprice")%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-3">
                                        <button type="submit" class="btn btn-primary">修改</button>
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
    </body>
</html>
