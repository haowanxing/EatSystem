/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Good;

import MysqlControl.MysqlController;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import wang.dshui.order.OrderGenerator;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
@WebServlet(name = "GoodEdit", urlPatterns = {"/admin/GoodEdit"})
public class GoodEdit extends HttpServlet {

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
        String tempDirectory = request.getRealPath("/") + "uploads/picture/";
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true);
            int sizeThreshold = 1024 * 64;  //写满该大小的缓存后，存入硬盘中。  
            File repositoryFile = new File(tempDirectory);
            FileItemFactory factory = new DiskFileItemFactory(sizeThreshold, repositoryFile);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("utf-8");  //设置字符编码  
            upload.setSizeMax(3 * 1024 * 1024); // set every upload file'size less than 3M  
            List items = upload.parseRequest(request);   //这里开始执行上传  
            Iterator iter = items.iterator();
            MysqlController MC = new MysqlController();
            String sql = "update goods set ";
            String data = "";
            String where = "";
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();   //FileItem就是表示一个表单域。
                if (item.isFormField()) { //isFormField方法用于判断FileItem是否代表一个普通表单域(即非file表单域)
                    String value = new String(item.getString().getBytes("iso-8859-1"),"utf-8");
                    data += item.getFieldName()+"=\""+value+"\",";
                    if(item.getFieldName().equals("gid")){
                        where = " where "+item.getFieldName()+"=\""+value+"\"";
                    }
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
                                data+="gpic=\""+"uploads/picture/"+fileName+"\",";
                            } else {
                                System.out.println("文件创建失败");
                            }
                        }
                        item.write(uploadedFile);
                    }
                }
            }
            data = data.substring(0, data.length()-1);
            sql+=data+where;
            System.out.println(sql);
            MC.executeUpdate(sql);
            if(MC.getCon()!=null){
                MC.Close();
            }
            request.getRequestDispatcher("menu.jsp").forward(request, response);
        } catch (FileUploadException ex) {
            Logger.getLogger(GoodEdit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(GoodEdit.class.getName()).log(Level.SEVERE, null, ex);
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
