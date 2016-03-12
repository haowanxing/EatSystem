<%-- 
    Document   : upload
    Created on : 2015-12-15, 12:15:26
    Author     : 刘经济 <york_mail@qq.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>上传图片</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script language="javascript" type="text/javascript" src="./jquery/1.11.3/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/func.js"></script>
        <script type="text/javascript">
            <!--
            function doCheck()
            {
                if (upload.img.value == '') {
                    alert('请选择文件!');
                    return false;
                }
                return true;
            }

            function setpicWH(ImgD, w, h)
            {
                var image = new Image();
                image.src = ImgD.src;
                if (image.width > 0 && image.height > 0)
                {
                    flag = true;
                    if (image.width / image.height >= w / h)
                    {
                        if (image.width > w)
                        {
                            ImgD.width = w;
                            ImgD.height = (image.height * w) / image.width;
                            ImgD.style.display = "block";
                        } else {
                            ImgD.width = image.width;
                            ImgD.height = image.height;
                            ImgD.style.display = "block";
                        }
                    } else {
                        if (image.height > h)
                        {
                            ImgD.height = h;
                            ImgD.width = (image.width * h) / image.height;
                            ImgD.style.display = "block";
                        } else {
                            ImgD.width = image.width;
                            ImgD.height = image.height;
                            ImgD.style.display = "block";
                        }
                    }
                }
            }
            //-->
        </script>
        <style type="text/css">
            <!--
            body { margin:0px; padding:0px; text-align:center; width:100%}
            img { border:#FF9900 1px solid}
            -->
        </style>
    </head>
    <body>
        <div style=" width:430px; height:auto; background:#CCCCCC; border:#999999 4px solid; margin:auto; margin-top:30px; padding-top:10px">

            <form action="<%=request.getContextPath()%>/fileupload" name="upload" id="form1" method="POST" onsubmit="return doCheck()" ENCTYPE="multipart/form-data" >
                <div style="text-align:center">文件上传</div>
                <table cellpadding="2" cellspacing="1" class="table_form" style="width:300px; margin:auto; text-align:center">
                    <tr>
                        <td>
                            <input type="file" name="img">
                            <input type="submit" name="dosubmit" value=" 上传 ">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" style=" padding-top:20px;">
                            <img id="previewpic" onload="setpicWH(this, 300, 300)">
                            <script type="text/javascript">
                                <!--
                                if ($("#img", window.opener.document).val())
                                {
                                    $("#previewpic").attr("src", http_pic($(window.opener.document).find("#img").val()));
                                }
                                else
                                {
                                    $("#previewpic").attr("src", "./img/none.jpg");
                                }
                                //-->
                            </script>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <script>
            function subform(){
                doCheck();
            }
        </script>
    </body>
</html>
