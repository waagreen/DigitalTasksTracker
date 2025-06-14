/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAOs.DAOTarefa;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author mvitoria
 */
//@WebServlet(name = "MainPage", urlPatterns = {"/MainPage"})
//public class MainPage extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        Cookie cookie = request.getCookies()[0];
//        DAOTarefa daoTarefa = new DAOTarefa();
//        List<Entidades.Tarefa> tarefas = daoTarefa.listByUsuario(cookie.getValue());
//        request.setAttribute("tarefas", tarefas);
//
//        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        // ARRUMAR PARA A LISTA TER APENAS AS TAREFAS DO TAL USUÁRIO E NÃO TODAS 
//        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        System.out.println("TOTAL DE TAREFAS NO BANCO DENTRO DO MAIN PAGE: " + tarefas.size());
//        for (Entidades.Tarefa t : tarefas) {
//            System.out.println(t.getTituloTarefa());
//        }
//
//        request.setAttribute("tarefas", tarefas);
//        request.getRequestDispatcher("mainPage.jsp").forward(request, response);
//    }
//}
