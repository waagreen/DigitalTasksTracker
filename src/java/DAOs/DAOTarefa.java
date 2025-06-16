package DAOs;

import Entidades.Tarefa;
import java.util.List;

/**
 *
 * @author mvitoria
 */
public class DAOTarefa extends DAOGenerico<Tarefa> {

    public DAOTarefa() {
        super(Tarefa.class);
    }

    public int autoIdTarefa() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.idTarefa) FROM Tarefa e").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public List<Tarefa> listByTitulo(String titulo) {
        return em.createQuery("SELECT e FROM Tarefa e WHERE e.tituloTarefa LIKE :tituloTarefa", Tarefa.class)
                .setParameter("titulo", "%" + titulo + "%")
                .getResultList();
    }

    public List<Tarefa> listByUsuario(int usuarioId) {
        return em.createQuery("SELECT e FROM Tarefa e WHERE e.usuario.id = :usuarioTarefa", Tarefa.class)
                .setParameter("id", usuarioId)
                .getResultList();
    }

    public List<Tarefa> listByUsuario(String usuarioId) {
        return em.createQuery("SELECT e FROM Tarefa e WHERE e.usuarioTarefa.usuario = :usuario", Tarefa.class)
                .setParameter("usuario", usuarioId)
                .getResultList();
    }
    
    public List<Tarefa> listByUsuario(String usuarioId, Boolean concluidaTarefa) {
        return em.createQuery("SELECT e FROM Tarefa e WHERE e.usuarioTarefa.usuario = :usuario AND e.concluidaTarefa = :concluida", Tarefa.class)
                .setParameter("usuario", usuarioId)
                .setParameter("concluida", concluidaTarefa)
                .getResultList();
    }

    public List<Tarefa> listInOrderTitulo() {
        return em.createQuery("SELECT e FROM Tarefa e ORDER BY e.tituloTarefa", Tarefa.class).getResultList();
    }

    public List<Tarefa> listInOrderId() {
        return em.createQuery("SELECT e FROM Tarefa e ORDER BY e.idTarefa", Tarefa.class).getResultList();
    }

    public List<Object[]> tempoGastoPorTag() {
        return em.createQuery("SELECT t.tagTarefa, SUM(t.tempoGasto) FROM Tarefa t GROUP BY t.tagTarefa").getResultList();
    }

    public List<String> listInOrderTituloStrings(String qualOrdem) {
        List<Tarefa> lt;
        if (qualOrdem.equals("idTarefa")) {
            lt = listInOrderId();
        } else {
            lt = listInOrderTitulo();
        }

        List<String> ls = new java.util.ArrayList<>();
        for (Tarefa t : lt) {
            ls.add(t.getTituloTarefa());
        }
        return ls;
    }

    public static void main(String[] args) {
        DAOTarefa daoTarefa = new DAOTarefa();
        List<Tarefa> tarefas = daoTarefa.list();
        for (Tarefa t : tarefas) {
            System.out.println(t.getTituloTarefa());
        }
    }
}
