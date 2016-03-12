/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package FileUpLoad;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import wang.dshui.order.OrderGenerator;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
public class UpLoader extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF8");
        String dir = "uploads/";
        String tempDirectory = request.getRealPath("/") + dir;
        try (PrintWriter out = response.getWriter()) {
            String result="0";
            int sizeThreshold = 1024 * 64;  //写满该大小的缓存后，存入硬盘中。  
            File repositoryFile = new File(tempDirectory);
            FileItemFactory factory = new DiskFileItemFactory(sizeThreshold, repositoryFile);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("utf-8");  //设置字符编码  
            upload.setSizeMax(3 * 1024 * 1024); // set every upload file'size less than 3M  
            List items = upload.parseRequest(request);   //这里开始执行上传  
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();   //FileItem就是表示一个表单域。
                if (item.isFormField()) { //isFormField方法用于判断FileItem是否代表一个普通表单域(即非file表单域)
                    String value = new String(item.getString().getBytes("iso-8859-1"),"utf-8");
                    
                } else {
                    String path = item.getName();
                    if(!path.equals("")){
                        String fileName = OrderGenerator.order(5) + path;
                        File uploadedFile = new File(tempDirectory + fileName);
                        if (uploadedFile.exists()) {
                            System.out.println("文件存在");
                        } else {
                            System.out.println("文件不存在" + uploadedFile.toString());
                            uploadedFile.getParentFile().mkdirs();
                            if (uploadedFile.createNewFile()) {
                                System.out.println("创建成功");
                                result = dir+fileName+"";
                            } else {
                                System.out.println("文件创建失败");
                            }
                        }
                        item.write(uploadedFile);
                    }
                }
            }
            if(result.equals("0")){
                out.println("失败了!");
            }else{
                out.println(result);
                out.println("<script language=\"javascript\" type=\"text/javascript\" src=\"./jquery/1.11.3/jquery.min.js\"></script>");
                out.println("<script language=\"javascript\" type=\"text/javascript\">");
		out.println("$(window.opener.document).find(\"#img\").val('"+result+"');");
		out.println("if(window.opener.uploadCall){window.opener.uploadCall(\"img\",\""+result+"\");}");
		out.println("window.close();");
                out.println("</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
