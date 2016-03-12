<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String islogin = null;
    String username = null;
    if(session.getAttribute("islogin") != null){
        islogin = session.getAttribute("islogin").toString();
    }
    if(islogin == null)
        islogin = "false";
    else if(islogin.equals("true"))
    {
        username = session.getAttribute("username").toString();
    }
%>
        <header class="navbar navbar-static-top " id="top" role="banner">
            <nav class="navbar navbar-default">
                <div class="container">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">不饿了网络订餐系统</a>
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="<%=request.getContextPath()%>/index.jsp">首页 <span class="sr-only">(current)</span></a></li>
                            <li><a href="login.jsp">链接</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">种类 <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">小吃</a></li>
                                    <li><a href="#">蔬果类</a></li>
                                    <li><a href="#">肉类</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="#">饮料</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="#">优惠券</a></li>
                                </ul>
                            </li>
                        </ul>
                            <form action="<%=request.getContextPath()%>/search.jsp" method="POST" class="navbar-form navbar-left" role="search">
                            <div class="form-group">
                                <input type="text" name="sname" class="form-control" placeholder="我想吃...">
                            </div>
                            <button type="submit" class="btn btn-default">搜索</button>
                        </form>
                        <ul class="nav navbar-nav navbar-right">
                            <% if(!islogin.equals("true")){%>
                            <li><a href="login.jsp">登陆/注册</a></li>
                            <% }else{ %>
                            <li><a href="<%=request.getContextPath()%>/cart.jsp">查看购物车</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="badge">4</span> 我的账户 <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="profile.jsp">个人中心</a></li>
                                    <li><a href="profile_info_addr.jsp">我的地址</a></li>
                                    <li><a href="profile_info_pwd.jsp">安全设置</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="User?act=logout">退出登录</a></li>
                                </ul>
                            </li>
                            <% }%>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>