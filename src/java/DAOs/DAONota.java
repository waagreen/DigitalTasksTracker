package DAOs;

import Entidades.Nota;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mvitoria
 */
public class DAONota extends DAOGenerico<Nota> {

    private List<Nota> lista = new ArrayList<>();

    public DAONota() {
        super(Nota.class);
    }

    public int autoIdNota() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.id) FROM Nota e ").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public List<Nota> listByNome(String nome) {
        return em.createQuery("SELECT e FROM Nota e WHERE e.id LIKE :nome").setParameter("nome", "%" + nome + "%").getResultList();
    }

    public List<Nota> listInOrderNome() {
        return em.createQuery("SELECT e FROM Nota e ORDER BY e.nome").getResultList();
    }

    public List<Nota> listById(int idNota) {
        return em.createQuery("SELECT e FROM Nota + e WHERE e.idNota= :id").setParameter("id", idNota).getResultList();
    }
    public List<Nota> listByUsuario(int usuarioId) {
        return em.createQuery("SELECT e FROM Nota e WHERE e.usuario.id = :usuarioNota", Nota.class)
                .setParameter("id", usuarioId)
                .getResultList();
    }
    public List<Nota> listByUsuario(String usuarioId) {
        return em.createQuery("SELECT e FROM Nota e WHERE e.usuarioNota.usuario = :usuario", Nota.class)
                .setParameter("usuario", usuarioId)
                .getResultList();
    }

    
    
    public List<Nota> listInOrderId() {
        return em.createQuery("SELECT e FROM Nota e ORDER BY e.id").getResultList();
    }

    public List<String> listInOrderNomeStrings(String qualOrdem) {
        List<Nota> lf;
        if (qualOrdem.equals("id")) {
            lf = listInOrderId();
        } else {
            lf = listInOrderNome();
        }

        List<String> ls = new ArrayList<>();
        for (int i = 0; i < lf.size(); i++) {
            ls.add(lf.get(i).getTituloNota());
        }
        return ls;
    }

    public static void main(String[] args) {
        DAONota daoNota = new DAONota();
        List<Nota> listaNota = daoNota.list();
        for (Nota nota : listaNota) {
            System.out.println(nota.getIdNota());
        }
    }
}
