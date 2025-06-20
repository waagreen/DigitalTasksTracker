package Servlets;

import DAOs.DAOTarefa;
import DAOs.DAOUsuario;
import Entidades.Tarefa;
import Entidades.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.CaixaDeFerramentas;

@WebServlet(name = "CadastrarTarefa", urlPatterns = {"/CadastrarTarefa"})
public class EditarTarefa extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CaixaDeFerramentas cdf = new CaixaDeFerramentas();
        DAOUsuario daoUsuario = new DAOUsuario();
        DAOTarefa daoTarefa = new DAOTarefa();
        
        String idTarefaStr = request.getParameter("idTarefa");

        Cookie[] cookie = request.getCookies();
        System.out.println("========================================================================================");
        for (int i = 0; i < cookie.length; i++) {
            System.out.println("Cookie NAME" + cookie[i].getName());
            System.out.println("Cookie VALUE" + cookie[i].getValue());
        }
        System.out.println("COOKIE LENGTH - 1 : " + cookie[cookie.length - 1].getValue());
        System.out.println("========================================================================================");
        
        if (idTarefaStr != null) {
            int idTarefa = Integer.parseInt(idTarefaStr);
            Entidades.Tarefa tarefa = daoTarefa.obter(idTarefa);
            if (tarefa != null) {
                String tituloTarefa = request.getParameter("tituloTarefa");
                String descricaoTarefa = request.getParameter("descricaoTarefa");
                String dataFinalizarTarefa = request.getParameter("dataFinalizarTarefa");
                String concluidaTarefa = request.getParameter("concluidaTarefa");
                String tempoGasto = request.getParameter("tempoGasto");
                String tagTarefa = request.getParameter("tagTarefa");
                
                tarefa.setTituloTarefa(tituloTarefa);
                tarefa.setDescricaoTarefa(descricaoTarefa);
                tarefa.setDataFinalizarTarefa(cdf.converteDeStringParaDate(dataFinalizarTarefa));
                tarefa.setConcluidaTarefa(cdf.converteDeStringParaBool(concluidaTarefa));
                tarefa.setTempoGasto(cdf.converteDeStringParaFloat(tempoGasto));
                tarefa.setTagTarefa(tagTarefa);
                
                daoTarefa.atualizar(tarefa);
                System.out.println("Tarefa atualizada com sucesso.");
            }else {
                System.out.println("Entidade Tarefa " + idTarefa + " não encontrada.");
            }
        } else {
            System.out.println("Parâmetro 'idTarefa' não foi enviado.");
        }

        response.sendRedirect("mainPage.jsp"); // redireciona após salvar
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOTarefa daoTarefa = new DAOTarefa();

        List<Tarefa> todas = daoTarefa.list();
        System.out.println("TOTAL DE TAREFAS NO BANCO: " + todas.size());
        for (Tarefa t : todas) {
            System.out.println(t.getTituloTarefa());
        }

    }

    @Override
    public String getServletInfo() {
        return "Servlet que cadastra uma tarefa";
    }
}
