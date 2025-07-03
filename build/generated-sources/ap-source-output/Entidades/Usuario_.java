package Entidades;

import Entidades.Lista;
import Entidades.Nota;
import Entidades.Tarefa;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-07-03T13:51:34", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Usuario.class)
public class Usuario_ { 

    public static volatile SingularAttribute<Usuario, String> senha;
    public static volatile ListAttribute<Usuario, Tarefa> tarefaList;
    public static volatile ListAttribute<Usuario, Lista> listaList;
    public static volatile SingularAttribute<Usuario, String> usuario;
    public static volatile ListAttribute<Usuario, Nota> notaList;

}