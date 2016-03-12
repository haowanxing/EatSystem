<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="MysqlControl.*,java.sql.*"%>
<% 
    String islogin = null;
    String username = null;
    String usernick = null;
    String userphone = null;
    String useremail = null;
    if(session.getAttribute("islogin") != null){
        islogin = session.getAttribute("islogin").toString();
    }
    if(islogin != null && islogin.equals("true"))
    {
        username = session.getAttribute("username").toString();
        usernick = session.getAttribute("usernick").toString();
        userphone = session.getAttribute("userphone").toString();
        useremail = session.getAttribute("useremail").toString();
    }else{
        request.getRequestDispatcher("error.jsp?error= 你没有登录!&param=  <a href=\"login.jsp\">现在去登录</a>").forward(request, response);
    }
    if(request.getAttribute("info")!=null){
        out.print(request.getAttribute("info"));
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
        <title>个人资料</title>
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
                        <a class="list-group-item btn btn-default active" href="profile_info.jsp">个人资料</a>
                        <a class="list-group-item btn btn-default" href="profile_info_addr.jsp">地址管理</a>
                        <a class="list-group-item btn btn-default" href="profile_info_pwd.jsp">修改密码</a>
                    </div>
                </div>
                <div class="col-md-10 col-xs-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">个人资料</div>
                        <div class="panel-body">
                            <form class="form-horizontal" action="User" method="post">
                                <input type="hidden" name="act" value="editinfo"/>
                                <input type="hidden" name="username" value="<%=username%>"/>
                            <div class="row col-md-offset-1 form-group">
                                <lable for="infopic" class="col-md-2  col-xs-4 control-label">头像:</lable>
                                <div class="col-sm-2 col-xs-4 thumbnail">
                                    <img id="infopic" src="img/pic_0.png" class="img-rounded" />
                                </div>
                                <!--<input type="file" name="upfile" size="50"/>-->
                            </div>
                                <div class="row col-md-offset-1 form-group">
                                    <lable for="infousername" class="col-md-2 col-xs-4 control-label">用户名:</lable>
                                    <div class="col-md-3 col-xs-7">
                                        <input id="infousername" class="form-control" type="text" name="info_username" value="<%=usernick%>"/>
                                    </div>
                                </div>
                                <div class="row col-md-offset-1 form-group">
                                    <lable for="infophone" class="col-md-2 col-xs-4 control-label">手机号:</lable>
                                    <div class="col-md-3 col-xs-7 ">
                                        <input id="infophone" class="form-control" type="text" name="info_phone" value="<%=userphone%>"/>
                                    </div>
                                </div>
                                <div class="row col-md-offset-1 form-group">
                                    <lable for="infomail" class="col-md-2 col-xs-4 control-label">邮箱:</lable>
                                    <div class="col-md-3 col-xs-7 ">
                                        <input id="infomail" class="form-control" type="text" name="info_mail" value="<%=useremail%>"/>
                                    </div>
                                </div>
                                <div class="row col-md-offset-1 form-group">
                                    <button type="submit" class="col-md-offset-3 col-xs-offset-9 btn btn-primary"> 保存 </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
