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
        return;
    }
    MysqlController MC = new MysqlController();
    if(request.getParameter("act")!=null && request.getParameter("act").equals("del")){
        String[] data = request.getParameterValues("ids[]");
        String sql = "delete from goods where ";
        if(data!=null)
        for(int i=0;i<data.length;i++){
            if(i==0)
                sql+="gid=\""+data[i]+"\"";
            else
                sql+=" or gid=\""+data[i]+"\"";
        }
        MC.executeUpdate(sql);
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
        <title>菜单管理</title>
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
                        <div class="col-md-7">
                            <ul class="nav nav-tabs">
                                <li role="presentation" class="active"><a href="#">全部菜单</a></li>
                                <li role="presentation"><a href="#">酒水类</a></li>
                                <li role="presentation"><a href="#">坚果类</a></li>
                                <li role="presentation"><a href="#">凉拌类</a></li>
                            </ul>
                        </div>
                        <div class="col-md-2 col-md-offset-3">
                            <ul class="nav nav-stacked">
                                <li role="presentation"><a href="./menu_add.jsp" class="text-success text-center">新增</a></li>
                            </ul>
                        </div>
                        <div class="row center-block">
                            <div class="col-sm-offset-0 col-sm-12">
                                <form method="get" id="form2" action>
                                    <input type="hidden" name="act" value="del"/>
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th><input type="checkbox" onclick="checkAll(this, 'ids[]')"></th><th>商品号</th><th>图片</th><th>餐品名</th><th>描述</th><th>价格</th>
                                    </tr>
                                    <%
                                        MC = new MysqlController();
                                        ResultSet rs = MC.getRs("select * from goods;");
                                        while (rs.next()) {%>
                                    <tr>
                                        <td><input type="checkbox" name="ids[]" value="<%=rs.getString("gid")%>" id="content_<%=rs.getString("gid")%>"></td><td><a href="./good_info.jsp?gid=<%=rs.getString("gid")%>"><%=rs.getString("gid")%></a></td><td><img src="../<%=rs.getString("gpic")%>" style="width:50px;height: 50px"/></td><td><%=rs.getString("gname")%></td><td><%=rs.getString("gdesc")%></td><td><%=rs.getString("gprice")%></td>
                                    </tr>
                                    <%}%>
                                </table>
                                <input type="submit" value="删除" class="myself" onclick="return confirm(&quot;确认要删除?&quot;)">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% if (MC != null) {
                MC.Close();
            }%>
        <jsp:include page="../footer.jsp" />
        <script>
            //全选/取消
            function checkAll(o, checkBoxName) {
                var oc = document.getElementsByName(checkBoxName);
                for (var i = 0; i < oc.length; i++) {
                    if (oc[i].disabled == false) {
                        if (o.checked) {
                            oc[i].checked = true;
                        } else {
                            oc[i].checked = false;
                        }
                    }
                }
            }
        </script>
    </body>
</html>
