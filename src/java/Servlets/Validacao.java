/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAOs.DAOUsuario;
import Entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author unknowndev
 */
@WebServlet(name = "Validacao", urlPatterns = {"/Validacao"})
public class Validacao extends HttpServlet {

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
            out.println("<title>Servlet Validacao</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Validacao at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();

        DAOUsuario daoUsuario = new DAOUsuario();
        Usuario usuario;

        String user = request.getParameter("user");
        String password = request.getParameter("pass");

        usuario = daoUsuario.obter(user);

        System.out.println("Usuário: " + usuario.toString());

        if (usuario != null) {
            if (password.equals(usuario.getSenha())) {
                Cookie cookie = new Cookie("user", user);
                cookie.setMaxAge(60 * 60);
                response.addCookie(cookie);
                System.out.println("COOKIE NA VALIDAÇÃO >>>>>>>>>>>>>>>>>>>>>>>>>> " + cookie.getValue());
                
                response.sendRedirect("mainPage.jsp");
                // REMOVER A TAG QUE INDICA A URI DA BIBLIOTECA JAVA SUN
                // NA PÁGINA .JSP, POIS ESTÁ CAUSANDO ERRO
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("index.html");
                rd.include(request, response);
                out.println("<h3>Usu&aacute;rio ou senha inv&aacute;lidos</h3>");
            }
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("index.html");
            rd.include(request, response);
            out.println("<h3>Usu&aacute;rio ou senha inv&aacute;lidos</h3>");
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
