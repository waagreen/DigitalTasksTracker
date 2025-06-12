package Servlets;

import DAOs.DAOTarefa;
import DAOs.DAOUsuario;
import Entidades.Tarefa;
import Entidades.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.CaixaDeFerramentas;

@WebServlet(name = "CadastrarTarefa", urlPatterns = {"/CadastrarTarefa"})
public class CadastrarTarefa extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CaixaDeFerramentas cdf = new CaixaDeFerramentas();
        DAOUsuario daoUsuario = new DAOUsuario();
        DAOTarefa daoTarefa = new DAOTarefa();

        String tituloTarefa = request.getParameter("tituloTarefa");
        String descricaoTarefa = request.getParameter("descricaoTarefa");
        String dataFinalizarTarefa = request.getParameter("dataFinalizarTarefa");

        Cookie[] cookie = request.getCookies();

        Usuario usuario = daoUsuario.obter(cookie[0].getValue());
        System.out.println("COOKIEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE " + usuario.toString());

        Tarefa tarefa = new Tarefa();
        tarefa.setTituloTarefa(tituloTarefa);
        tarefa.setDescricaoTarefa(descricaoTarefa);
        tarefa.setDataFinalizarTarefa(cdf.converteDeStringParaDate(dataFinalizarTarefa));
        tarefa.setUsuarioTarefa(usuario);
        daoTarefa.inserir(tarefa); // usando método herdado de DAOGenerico

        response.sendRedirect("mainPage.jsp"); // redireciona após salvar
    }

    @Override
    public String getServletInfo() {
        return "Servlet que cadastra uma tarefa";
    }
}
