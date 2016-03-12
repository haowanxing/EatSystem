<%-- 
    Document   : reg
    Created on : 2015-11-3, 20:24:37
    Author     : 刘经济 <york_mail@qq.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/docs.min.css" rel="stylesheet">
        <title>用户注册</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <form class="form-horizontal" action="User" method="post">
                <input type="hidden" name="act" value="register"/>
                <div class="form-group">
                    <label for="inputUsername" class="col-sm-5 control-label">用户名/昵称：</label>
                    <div class="col-sm-3">
                        <input type="text" name="username" class="form-control" id="inputUsername" placeholder="输入您的用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-5 control-label">密码：</label>
                    <div class="col-sm-3">
                        <input type="password" name="password" class="form-control" id="inputPassword" placeholder="输入您的密码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-5 control-label">手机号码：</label>
                    <div class="col-sm-3">
                        <input type="text" name="phone" class="form-control" id="inputPassword" placeholder="请输入手机号">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-5 col-xs-offset-1 col-sm-1 col-xs-4">
                        <button type="submit" class="btn btn-primary"> 提交 </button>
                    </div>
                    <div class="col-sm-offset-0 col-sm-4">
                        <a href="login.jsp" class="btn btn-success">已经有账号？</a>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
