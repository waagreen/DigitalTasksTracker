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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author unknowndev
 */
@WebServlet(name = "CRUDUsuario", urlPatterns = {"/CRUDUsuario"})
public class CRUDUsuario extends HttpServlet {

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
            out.println("<title>Servlet CRUDUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CRUDUsuario at " + request.getContextPath() + "</h1>");
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

        DAOUsuario daoUsuario = new DAOUsuario();
        Usuario login = new Usuario();

        String Status = request.getParameter("Status");
        String userName = request.getParameter("userName");

        // --------------------------- BUSCAR ------------------------
        if (Status.equals("0")) {
            try {
                login = daoUsuario.obter(userName);

                if (login == null) {

                    PrintWriter out = response.getWriter();

                    RequestDispatcher rd = request.getRequestDispatcher("Usuarioistrador.jsp");
                    rd.include(request, response);

                    out.println("<form action=\"CRUDUsuario\" method=\"post\">");
                    out.println("<div class=\"mb-3\">");
                    out.println("<p><input class=\"form-control\" type=\"text\" name=\"Status\" id=\"Status\" value=\"1\" hidden required />");
                    out.println("<p><input class=\"form-control\" type=\"text\" name=\"userName\" id=\"userName\" readonly placeholder=\"Nome do loginistrador\" value=\"" + userName + "\"required/>");
                    out.println("<p><input class=\"form-control\" type=\"password\" name=\"Password\" id=\"Password\" maxlength=\"16\" placeholder=\"Senha\" required/>");
                    out.println("<p><button class=\"btn btn-primary\" type=\"submit\">Enviar</button>");
                    out.println("<button class=\"btn btn-secondary\" type=\"reset\">Limpar</button>");
                    out.println("</div>");
                    out.println("</form>");

                } else {
                    String Password = login.getSenha();

                    PrintWriter out = response.getWriter();
                    RequestDispatcher rd = request.getRequestDispatcher("Administrador.jsp");
                    rd.include(request, response);

                    out.println("<form action=\"CRUDUsuario\" method=\"post\">");
                    out.println("<div class=\"mb-3\">");
                    out.println("<p><input class=\"form-control\" type=\"text\" name=\"Status\" id=\"Status\" value=\"2\" hidden />");
                    out.println("<p><input class=\"form-control\" type=\"text\" name=\"userName\" id=\"userName\" readonly placeholder=\"Nome do loginistrador\" value=\"" + userName + "\"required/>");
                    out.println("<p><input class=\"form-control\" type=\"password\" name=\"Password\" id=\"Password\" maxlength=\"16\" placeholder=\"Senha\" value=\"" + Password + "\" required/>");
                    out.println("<p><input type=\"radio\" id=\"delete\" name=\"option\" value=\"delete\" required>\n"
                            + "<label for=\"delete\">Deletar</label>\n"
                            + "<input type=\"radio\" id=\"update\" name=\"option\" value=\"update\" checked>\n"
                            + "<label for=\"update\">Alterar</label>");
                    out.println("<p><button class=\"btn btn-primary\" type=\"submit\">Enviar</button>");
                    out.println("<button class=\"btn btn-secondary\" type=\"reset\">Limpar</button>");
                    out.println("</div>");
                    out.println("</form>");

                }
            } catch (Exception erro2) {
                System.out.println("ixi");
            }

        } else if (Status.equals("1")) {

            login = new Usuario();

            String Name = request.getParameter("userName");
            String Password = request.getParameter("Password"); ///// --------------------------- Alterar -------------------------------------

            login.setUsuario(Name);
            login.setSenha(Password);

            daoUsuario.inserir(login);

            PrintWriter out = response.getWriter();
            RequestDispatcher rd = request.getRequestDispatcher("Usuario.jsp");

            rd.include(request, response);
            out.println("<h3>Usuarioistrador adicionado com sucesso!</h3>");

        } else if (Status.equals("2")) {
            String option = request.getParameter("option");

            if (option.equals("update")) {

                login = new Usuario();

                String Name = request.getParameter("userName");
                String Password = request.getParameter("Password"); ///// --------------------------- Alterar -------------------------------------

                login.setUsuario(Name);
                login.setSenha(Password);

                daoUsuario.atualizar(login);

                PrintWriter out = response.getWriter();
                RequestDispatcher rd = request.getRequestDispatcher("Usuario.jsp");

                rd.include(request, response);
                out.println("<h3>Usuarioistrador alterado com sucesso!</h3>");

            } else if (option.equals("delete")) {

                String Name = request.getParameter("userName");
                
                login = daoUsuario.obter(Name);
                daoUsuario.remover(login);

                PrintWriter out = response.getWriter();
                RequestDispatcher rd = request.getRequestDispatcher("Usuario.jsp");

                rd.include(request, response);
                out.println("<h3>Usuarioistrador removido com sucesso!</h3>");

            }

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
