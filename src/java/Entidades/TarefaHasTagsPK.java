/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author mvitoria
 */
@Embeddable
public class TarefaHasTagsPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "idTarefa", nullable = false)
    private int idTarefa;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "nomeTag", nullable = false, length = 45)
    private String nomeTag;

    public TarefaHasTagsPK() {
    }

    public TarefaHasTagsPK(int idTarefa, String nomeTag) {
        this.idTarefa = idTarefa;
        this.nomeTag = nomeTag;
    }

    public int getIdTarefa() {
        return idTarefa;
    }

    public void setIdTarefa(int idTarefa) {
        this.idTarefa = idTarefa;
    }

    public String getNomeTag() {
        return nomeTag;
    }

    public void setNomeTag(String nomeTag) {
        this.nomeTag = nomeTag;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idTarefa;
        hash += (nomeTag != null ? nomeTag.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TarefaHasTagsPK)) {
            return false;
        }
        TarefaHasTagsPK other = (TarefaHasTagsPK) object;
        if (this.idTarefa != other.idTarefa) {
            return false;
        }
        if ((this.nomeTag == null && other.nomeTag != null) || (this.nomeTag != null && !this.nomeTag.equals(other.nomeTag))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entidades.TarefaHasTagsPK[ idTarefa=" + idTarefa + ", nomeTag=" + nomeTag + " ]";
    }
    
}
