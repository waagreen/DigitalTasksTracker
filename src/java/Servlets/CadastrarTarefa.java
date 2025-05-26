package Servlets;

import DAOs.DAOTarefa;
import Entidades.Tarefa;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.CaixaDeFerramentas;

@WebServlet(name = "CadastrarTarefa", urlPatterns = {"/CadastrarTarefa"})
public class CadastrarTarefa extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String titulo = request.getParameter("titulo");
        String descricao = request.getParameter("descricao");
        String dataFinalizarTarefa = request.getParameter("dataFinalizarTarefa");
        
        CaixaDeFerramentas cdf = new CaixaDeFerramentas();
        Tarefa tarefa = new Tarefa();
        tarefa.setTituloTarefa(titulo);
        tarefa.setDescricaoTarefa(descricao);
        tarefa.setDataFinalizarTarefa(cdf.converteDeStringParaDate(dataFinalizarTarefa)); 
        //tarefa.serConcluida(false); // por padrão, começa como não concluída
        
        DAOTarefa dao = new DAOTarefa();
        dao.inserir(tarefa); // usando método herdado de DAOGenerico

        response.sendRedirect("ListarTarefasServlet"); // redireciona após salvar
    }

    @Override
    public String getServletInfo() {
        return "Servlet que cadastra uma tarefa";
    }
}
