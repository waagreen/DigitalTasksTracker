/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAOs.DAOTarefa;
import DAOs.DAOUsuario;
import Entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.CaixaDeFerramentas;

/**
 *
 * @author leonardo
 */
@WebServlet(name = "ConcluirTarefa", urlPatterns = {"/ConcluirTarefa"})
public class ConcluirTarefa extends HttpServlet {

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
            out.println("<title>Servlet ExcluirTarefa</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExcluirTarefa at " + request.getContextPath() + "</h1>");
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
        
        
        System.out.println(" BOTÃO DE CONCLUIR PRESSIONADO ------------- ");
        CaixaDeFerramentas cdf = new CaixaDeFerramentas();
        DAOUsuario daoUsuario = new DAOUsuario();
        DAOTarefa daoTarefa = new DAOTarefa();
        
        //Entidades.Tarefa tarefa = new Entidades.Tarefa();
        String idTarefaStr = request.getParameter("idTarefa");
        if (idTarefaStr != null) {
            int idTarefa = Integer.parseInt(idTarefaStr);
            Entidades.Tarefa tarefa = daoTarefa.obter(idTarefa);
            if (tarefa != null) {
                //Mudar o status da tarefa para concluida
                tarefa.setConcluidaTarefa(Boolean.TRUE);
                daoTarefa.atualizar(tarefa);
                System.out.println("Tarefa concluida com sucesso.");
            }else {
                System.out.println("Entidade Tarefa " + idTarefa + " não encontrada.");
            }
        } else {
            System.out.println("Parâmetro 'idTarefa' não foi enviado.");
        }
        response.sendRedirect("mainPage.jsp"); // redireciona após salvar
 
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