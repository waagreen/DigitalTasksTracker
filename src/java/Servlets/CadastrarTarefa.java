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
        System.out.println("========================================================================================");
        for (int i = 0; i < cookie.length; i++) {
            System.out.println("Cookie NAME" + cookie[i].getName());
            System.out.println("Cookie VALUE" + cookie[i].getValue());
        }
        System.out.println("COOKIE LENGTH - 1 : " + cookie[cookie.length - 1].getValue());
        System.out.println("========================================================================================");

        Usuario usuario = null;
        for (int i = 0; i < cookie.length; i++) {
            if ((cookie[i].getName()).equals("user")) {
                System.out.println("USUARIO QUE FOI ENVIADOOOO - CADASTRAR TAREFA::: " + cookie[i].getValue());
                usuario = daoUsuario.obter(cookie[i].getValue());
            }
        }

//        Usuario usuario = daoUsuario.obter(cookie[cookie.length - 1].getValue());;
        Tarefa tarefa = new Tarefa();
        tarefa.setTituloTarefa(tituloTarefa);
        tarefa.setDescricaoTarefa(descricaoTarefa);
        tarefa.setDataFinalizarTarefa(cdf.converteDeStringParaDate(dataFinalizarTarefa));
        tarefa.setUsuarioTarefa(usuario);
        daoTarefa.inserir(tarefa); // usando método herdado de DAOGenerico

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
