/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAOs.DAOTarefa;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

/**
 *
 * @author mvitoria
 */
@WebServlet(name = "GerenciarTags", urlPatterns = {"/GerenciarTags"})
public class GerenciarTags extends HttpServlet {

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
            out.println("<title>Servlet GerenciarTags</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GerenciarTags at " + request.getContextPath() + "</h1>");
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

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String action = request.getParameter("action");
        String idTarefaStr = request.getParameter("idTarefa");
        String tagNome = request.getParameter("tagNome");

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            int idTarefa = Integer.parseInt(idTarefaStr);

            DAOTarefa dao = new DAOTarefa();
            Entidades.Tarefa tarefa = dao.obter(idTarefa);

            if (tarefa == null) {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Tarefa não encontrada.");
                response.getWriter().write(new Gson().toJson(jsonResponse));
                return;
            }

            // Carrega tags atuais da tarefa
            String tagsStr = tarefa.getTagTarefa();
            List<String> tagsList = new ArrayList<>();
            if (tagsStr != null && !tagsStr.trim().isEmpty()) {
                for (String t : tagsStr.split(",")) {
                    if (!t.trim().isEmpty()) {
                        tagsList.add(t.trim());
                    }
                }
            }

            if ("add".equals(action)) {
                if (tagNome != null && !tagNome.trim().isEmpty()) {
                    if (!tagsList.contains(tagNome.trim())) {
                        tagsList.add(tagNome.trim());
                    }
                }
            } else if ("remove".equals(action)) {
                tagsList.removeIf(tag -> tag.equalsIgnoreCase(tagNome.trim()));
            }

            // Atualiza campo tagTarefa no banco
            String novasTagsStr = String.join(", ", tagsList);
            tarefa.setTagTarefa(novasTagsStr);
            dao.atualizar(tarefa);

            jsonResponse.put("status", "success");
            jsonResponse.put("tags", novasTagsStr);

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Erro interno no servidor.");
        }

        response.getWriter().write(new Gson().toJson(jsonResponse));
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
