/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package User;

import MysqlControl.MysqlController;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
public class Admin extends HttpServlet {

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
            String act = "default";
            HttpSession session = request.getSession(true);
            if(request.getParameter("act") != null){
                act = request.getParameter("act");
            }
            switch(act){
                case "logout":
                    System.out.println("用户退出");
                    session.removeAttribute("aislogin");
                    session.removeAttribute("ausername");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                default:
                    break;
            }
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
            //processRequest(request, response);
            String Username,Password,act=null;
            HttpSession session = request.getSession(true);
            act = request.getParameter("act");
            MysqlController MC = new MysqlController();
            ResultSet rs;
            switch(act){
                case "login":
                    Username = request.getParameter("ausername");
                    Password = request.getParameter("apassword");
                    rs = MC.getRs("select * from admins where aid =\""+Username+"\";");
                    while(rs.next()){
                        if(Password.equals(rs.getString("apwd"))){
                            session.setAttribute("ausername", Username);
                            session.setAttribute("aislogin", "true");
                            session.setAttribute("ausernick", rs.getString("aname"));
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }else{
                            request.getRequestDispatcher("login.jsp?error= 密码错误!").forward(request, response);
                        }
                        return;
                        //break;
                    }
                    request.getRequestDispatcher("login.jsp?error= 用户名不存在!").forward(request, response);
                    break;
                case "register":
                    
                    break;
                default:
                    break;
            }
            if(MC.getCon()!=null){
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
