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
public class User extends HttpServlet {

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
                    session.removeAttribute("islogin");
                    session.removeAttribute("username");
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
        try (PrintWriter out = response.getWriter()){
            //processRequest(request, response);
            String Username,Usernick,Usermail,Userphone,Password,act=null;
            HttpSession session = request.getSession(true);
            act = request.getParameter("act");
            if(session.getAttribute("islogin")!=null&&session.getAttribute("islogin").equals("true")){
                
            }else if(act.equals("login") || act.equals("register")){
                
            }else{
                request.getRequestDispatcher("error.jsp?error=没有登录!请登录后进行操作.").forward(request, response);
                return;
            }
            MysqlController MC = new MysqlController();
            String sql="";
            ResultSet rs;
            switch(act){
                case "login":
                    Username = request.getParameter("username");
                    Password = request.getParameter("password");
                    rs = MC.getRs("select * from custorms where cid =\""+Username+"\";");
                    int flag=1;
                    while(rs.next()){
                        flag=0;
                        if(Password.equals(rs.getString("cpwd"))){
                            session.setAttribute("username", Username);
                            session.setAttribute("islogin", "true");
                            session.setAttribute("usernick", rs.getString("cname"));
                            session.setAttribute("userphone", rs.getString("cphone"));
                            session.setAttribute("useremail", rs.getString("cmail"));
                            session.setAttribute("useraddr", rs.getString("cadr"));
                            request.getRequestDispatcher("profile.jsp").forward(request, response);
                        }else{
                            request.getRequestDispatcher("error.jsp?error= 密码错误!").forward(request, response);
                        }
                        break;
                    }
                    if(flag==1)
                        request.getRequestDispatcher("error.jsp?error= 用户名不存在!").forward(request, response);
                    break;
                case "register":
                    Username = request.getParameter("username");
                    Password = request.getParameter("password");
                    rs = MC.getRs("select * from custorms where cid =\""+Username+"\";");
                    while(rs.next()){
                        request.getRequestDispatcher("error.jsp?error=用户名已经存在!").forward(request, response);
                        break;
                    }
                    sql = "insert into custorms values (null,\""+Username+"\",\"\",\""+Password+"\",\""+request.getParameter("phone")+"\",\"无\",\"无\");";
                    //System.out.println(sql);
                    int res = MC.executeUpdate(sql);
                    if(res == 1){
                        session.setAttribute("username", Username);
                        session.setAttribute("islogin", "true");
                        session.setAttribute("usernick", Username);
                        session.setAttribute("useremail", "");
                        session.setAttribute("useraddr", "请设置");
                        request.getRequestDispatcher("profile.jsp").forward(request, response);
                    }else{
                        request.getRequestDispatcher("error.jsp?error=填写错误,请认真按要求填写表格!").forward(request, response);
                    }
                    break;
                case "editinfo":
                    Username = request.getParameter("username");
                    Usernick = request.getParameter("info_username");
                    Usermail = request.getParameter("info_mail");
                    Userphone = request.getParameter("info_phone");
                    session.setAttribute("usernick", Usernick);
                    session.setAttribute("userphone", Userphone);
                    session.setAttribute("useremail", Usermail);
                    sql="update custorms set cname=\""+Usernick+"\",cphone=\""+Userphone+"\",cmail=\""+Usermail+"\" where cid=\""+Username+"\"";
                    System.out.println(sql);
                    int num = MC.executeUpdate(sql);
                    if(num!=1){
                        request.getRequestDispatcher("error.jsp?error=保存失败!亲稍后再试.").forward(request, response);
                    }else{
                        request.setAttribute("info", "<script>alert('提交成功!')</script>");
                        request.getRequestDispatcher("profile_info.jsp").forward(request, response);
                    }
                    break;
                case "chpwd":
                    Username = session.getAttribute("username").toString();
                    String oldpwd,newpwd;
                    if(request.getParameter("oldpassword")!=null && request.getParameter("newpassword")!=null){
                        oldpwd = request.getParameter("oldpassword").toString();
                        newpwd = request.getParameter("newpassword").toString();
                        sql = "update custorms set cpwd=\""+newpwd+"\" where cid=\""+Username+"\" and cpwd=\""+oldpwd+"\"";
                        response.getWriter().println(MC.executeUpdate(sql));
                    }else{
                        response.getWriter().println("出错了");
                        break;
                    }
                    break;
                case "chaddr":
                    Username = session.getAttribute("username").toString();
                    String addr;
                    if(request.getParameter("useraddr")!=null){
                        addr = request.getParameter("useraddr").toString();
                        sql = "update custorms set cadr=\""+addr+"\" where cid=\""+Username+"\"";
                        int effect = MC.executeUpdate(sql);
                        if(effect==1)
                            session.setAttribute("useraddr", addr);
                        response.getWriter().println(effect);
                    }else{
                        response.getWriter().println("出错了");
                        break;
                    }
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
