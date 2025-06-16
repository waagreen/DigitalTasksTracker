/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

import java.io.Serializable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author mvitoria
 */
@Entity
@Table(name = "tarefa_has_tags")
@NamedQueries({
    @NamedQuery(name = "TarefaHasTags.findAll", query = "SELECT t FROM TarefaHasTags t"),
    @NamedQuery(name = "TarefaHasTags.findByIdTarefa", query = "SELECT t FROM TarefaHasTags t WHERE t.tarefaHasTagsPK.idTarefa = :idTarefa"),
    @NamedQuery(name = "TarefaHasTags.findByNomeTag", query = "SELECT t FROM TarefaHasTags t WHERE t.tarefaHasTagsPK.nomeTag = :nomeTag")})
public class TarefaHasTags implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TarefaHasTagsPK tarefaHasTagsPK;
    @JoinColumn(name = "idTarefa", referencedColumnName = "idTarefa", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Tarefa tarefa;

    public TarefaHasTags() {
    }

    public TarefaHasTags(TarefaHasTagsPK tarefaHasTagsPK) {
        this.tarefaHasTagsPK = tarefaHasTagsPK;
    }

    public TarefaHasTags(int idTarefa, String nomeTag) {
        this.tarefaHasTagsPK = new TarefaHasTagsPK(idTarefa, nomeTag);
    }

    public TarefaHasTagsPK getTarefaHasTagsPK() {
        return tarefaHasTagsPK;
    }

    public void setTarefaHasTagsPK(TarefaHasTagsPK tarefaHasTagsPK) {
        this.tarefaHasTagsPK = tarefaHasTagsPK;
    }

    public Tarefa getTarefa() {
        return tarefa;
    }

    public void setTarefa(Tarefa tarefa) {
        this.tarefa = tarefa;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tarefaHasTagsPK != null ? tarefaHasTagsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TarefaHasTags)) {
            return false;
        }
        TarefaHasTags other = (TarefaHasTags) object;
        if ((this.tarefaHasTagsPK == null && other.tarefaHasTagsPK != null) || (this.tarefaHasTagsPK != null && !this.tarefaHasTagsPK.equals(other.tarefaHasTagsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.TarefaHasTags[ tarefaHasTagsPK=" + tarefaHasTagsPK + " ]";
    }
    
}
