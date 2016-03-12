/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Order;

import MysqlControl.MysqlController;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 刘经济 <york_mail@qq.com>
 */
@WebServlet(name = "OrderUpdate", urlPatterns = {"/OrderUpdate"})
public class OrderUpdate extends HttpServlet {

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
            out.println("<title>Servlet OrderUpdate</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderUpdate at " + request.getContextPath() + "</h1>");
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
        String from,oid,gname,cname,cid,phone,caddr,tp,num,ostat,disid;
        String sql = null;
        if(request.getParameter("from")!=null){
            from = request.getParameter("from");
            oid = request.getParameter("goodoid");
            gname = request.getParameter("goodname");
            cname = request.getParameter("username");
            cid = request.getParameter("userid");
            caddr = request.getParameter("caddr");
            tp = request.getParameter("totalprice");
            num = request.getParameter("num");
            ostat = request.getParameter("ostats");
            disid = request.getParameter("disid");
            phone = request.getParameter("phone");
        }else{
            request.getRequestDispatcher("error.jsp?error= 错误的请求!").forward(request, response);
            return;
        }
        MysqlController MC = new MysqlController();
        switch(from){
            case "gm":
                sql = "update orders set cadr=\""+caddr+"\",gnum=\""+num+"\",ostat=\""+ostat+"\",cphone=\""+phone+"\" where oid=\""+oid+"\"";
                break;
            case "dis":
                sql = "update orders set cadr=\""+caddr+"\",gnum=\""+num+"\",ostat=\""+ostat+"\",disid=\""+disid+"\" where oid=\""+oid+"\"";
                break;
            default:
                return;
        }
        if(sql!=null){
            int effect = MC.executeUpdate(sql);
            response.getWriter().println(effect);
        }
        MC.Close();
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
