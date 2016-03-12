<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/docs.min.css" rel="stylesheet">
        <title>修改密码</title>
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
                        <a class="list-group-item btn btn-default active" href="profile_info_pwd.jsp">修改密码</a>
                    </div>
                </div>
                <div class="col-md-10  col-xs-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">修改密码</div>
                        <div class="panel-body">
                            <form id="form1" action="User" method="post">
                                <input type="hidden" name="act" value="chpwd"/>
                                <div class="row col-md-offset-1 form-group">
                                    <label for="oldpwd" class="col-md-2 col-xs-4 control-label">旧密码：</label>
                                    <div class="col-md-3 col-xs-6">
                                        <input class="form-control" type="password" id="oldpwd" name="oldpassword" />
                                    </div>
                                </div>
                                <div class="row col-md-offset-1 form-group">
                                    <label for="newpwd" class="col-md-2 col-xs-4 control-label">新密码：</label>
                                    <div class="col-md-3 col-xs-6">
                                        <input class="form-control" type="password" id="newpwd" name="newpassword" />
                                    </div>
                                </div>
                                <div class="row col-md-offset-1 form-group">
                                    <button type="button" onclick="subform()" class="col-md-offset-4 col-xs-offset-8 btn btn-primary"> 提交 </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp" />
        <script>
            function subform(){
                $.post($("#form1").attr("action"), $("#form1").serialize(),function(data){
                    if(data == 1){
                        alert("提交成功!");
                        window.location.href = "./profile_info_pwd.jsp";
                    }else{
                        alert("信息有误或填写不正确,操作失败 err:"+data);
                    }
                });
            }
        </script>
    </body>
</html>
