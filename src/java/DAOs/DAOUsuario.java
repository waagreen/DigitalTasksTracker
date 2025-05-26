package DAOs;

import Entidades.Usuario;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mvitoria
 */
public class DAOUsuario extends DAOGenerico<Usuario> {

    private List<Usuario> lista = new ArrayList<>();

    public DAOUsuario() {
        super(Usuario.class);
    }

    public int autoIdUsuario() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.id) FROM Usuario e ").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public List<Usuario> listByNome(String nome) {
        return em.createQuery("SELECT e FROM Usuario e WHERE e.id LIKE :nome").setParameter("nome", "%" + nome + "%").getResultList();
    }

    public List<Usuario> listInOrderNome() {
        return em.createQuery("SELECT e FROM Usuario e ORDER BY e.nome").getResultList();
    }

    public List<Usuario> listById(int idUsuario) {
        return em.createQuery("SELECT e FROM Usuario + e WHERE e.idUsuario= :id").setParameter("id", idUsuario).getResultList();
    }

    public List<Usuario> listInOrderId() {
        return em.createQuery("SELECT e FROM Usuario e ORDER BY e.id").getResultList();
    }

    public List<String> listInOrderNomeStrings(String qualOrdem) {
        List<Usuario> lf;
        if (qualOrdem.equals("id")) {
            lf = listInOrderId();
        } else {
            lf = listInOrderNome();
        }

        List<String> ls = new ArrayList<>();
        for (int i = 0; i < lf.size(); i++) {
            ls.add(lf.get(i).getUsuario());
        }
        return ls;
    }

    public static void main(String[] args) {
        DAOUsuario daoUsuario = new DAOUsuario();
        List<Usuario> listaUsuario = daoUsuario.list();
        for (Usuario admin : listaUsuario) {
            System.out.println(admin.getUsuario());
        }
    }
}
