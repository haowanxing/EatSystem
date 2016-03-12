/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package User;

import MysqlControl.MysqlController;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
@WebServlet(name = "DisEdit", urlPatterns = {"/DisEdit"})
public class DisEdit extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DisEdit</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DisEdit at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            String act, disid, disname, dispwd, disphone = null,dis=null,sql=null;
            MysqlController MC=null;
            int effect;
            if(request.getParameter("act")!=null)
            if(request.getParameter("disid")!=null){
                act = request.getParameter("act");
                dis = request.getParameter("dis");
                disid = request.getParameter("disid");
                disname = request.getParameter("disname");
                dispwd = request.getParameter("dispwd");
                disphone = request.getParameter("disphone");
                MC = new MysqlController();
                switch(act){
                    case "edit":
                        sql = "update distribution set disid=\""+disid+"\",disname=\""+disname+"\",disphone=\""+disphone+"\"";
                        if(!dispwd.equals("")){
                            sql+=",dispwd=\""+dispwd+"\"";
                        }
                        sql+=" where disid=\""+dis+"\"";
                        effect = MC.executeUpdate(sql);
                        response.getWriter().println(effect);
                        break;
                    case "add":
                        sql = "insert into distribution (disid,dispwd,disname,disphone) values (\""+disid+"\",\""+dispwd+"\",\""+disname+"\",\""+disphone+"\")";
                        effect = MC.executeUpdate(sql);System.out.println(sql);
                        response.getWriter().println(effect);
                        break;
                    default:
                        return;
                }
            }else{
                response.getWriter().println("No query data real");
            }
            else{
                response.getWriter().println("illegle");
            }
            if (MC != null) {
                MC.Close();
            }
        } catch (Exception ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
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
