package Entidades;

import Entidades.Usuario;
import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-05-26T13:58:16", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Tarefa.class)
public class Tarefa_ { 

    public static volatile SingularAttribute<Tarefa, Date> dataFinalizarTarefa;
    public static volatile SingularAttribute<Tarefa, String> tituloTarefa;
    public static volatile SingularAttribute<Tarefa, Integer> idTarefa;
    public static volatile SingularAttribute<Tarefa, Usuario> usuarioTarefa;
    public static volatile SingularAttribute<Tarefa, String> descricaoTarefa;

}