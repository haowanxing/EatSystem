<%-- 
    Document   : login
    Created on : 2015-11-3, 20:33:25
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
        <title>用户登陆</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <form class="form-horizontal" action="User" method="post">
                <input type="hidden" name="act" value="login"/>
                <div class="form-group">
                    <label for="inputUsername" class="col-sm-5 control-label">用户名：</label>
                    <div class="col-sm-3">
                        <input type="test" name="username" class="form-control" id="inputUsername" placeholder="输入您的用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-5 control-label">密码：</label>
                    <div class="col-sm-3">
                        <input type="password" name="password" class="form-control" id="inputPassword" placeholder="输入您的密码">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-5 col-xs-offset-1 col-sm-1 col-xs-4">
                        <button type="submit" class="btn btn-primary">登陆</button>
                    </div>
                    <div class="col-sm-offset-0 col-sm-4">
                        <a href="reg.jsp" class="btn btn-success">还没有账号？注册</a>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
