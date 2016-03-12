/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Good;

import MysqlControl.MysqlController;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import wang.dshui.order.OrderGenerator;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
public class Good extends HttpServlet {

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
            String sql,username=null,act=null,gid=null,oid=null,caddr=null,phone=null,name=null;
            String gname=null,gdesc=null,gpic=null,gprice=null;
            int gnum=1,effect=0;
            HttpSession session = request.getSession(true);
            if(session.getAttribute("username")!=null && session.getAttribute("islogin")!=null){
                username = session.getAttribute("username").toString();
                caddr = session.getAttribute("useraddr").toString();
                phone = session.getAttribute("userphone").toString();
                name = session.getAttribute("usernick").toString();
                gnum = Integer.parseInt(request.getParameter("goodnum"));
            }else if(session.getAttribute("aislogin")!=null){
                gname = request.getParameter("gname");
                gdesc = request.getParameter("gdesc");
                gpic = request.getParameter("gpic");
                gprice = request.getParameter("gprice");
                
            }else{
                request.getRequestDispatcher("error.jsp?error= 您还没有登录!").forward(request, response);
            }
            act = request.getParameter("act");
            gid = request.getParameter("gid");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String otime = sdf.format(new Date());
            MysqlController MC = new MysqlController();
            switch(act){
                case "order":
                    oid = OrderGenerator.order();
                    sql="insert into orders(oid,cid,cname,gid,gnum,cphone,cadr,otime,disid) values (\""+oid+"\",\""+username+"\",\""+name+"\",\""+gid+"\",\""+gnum+"\",\""+phone+"\",\""+caddr+"\",\""+otime+"\",\"0\")";
                    effect = MC.executeUpdate(sql);
                    if(effect != 1)
                        request.getRequestDispatcher("error.jsp?error= 系统异常,下单失败!").forward(request, response);
                    else
                        request.getRequestDispatcher("tips.jsp?text= 下单成功!&param=<a href=\"profile_order_all.jsp\">查看订单</a>").forward(request, response);
                    break;
                case "add":
                    sql="insert into goods(gid,gname,gdesc,gpic,gprice) values (\""+gid+"\",\""+gname+"\",\""+gdesc+"\",\""+gpic+"\",\""+gprice+"\")";
                    effect = MC.executeUpdate(sql);
                    response.getWriter().println(effect);
                    break;
                default:
                    break;
            }
            if(MC.getCon()!=null){
                MC.Close();
            }
        } catch (Exception ex) {
            Logger.getLogger(Good.class.getName()).log(Level.SEVERE, null, ex);
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
