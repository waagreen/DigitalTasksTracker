/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servlets;

/**
 *
 * @author mvitoria
 */
public class Tarefa {
    
    private int idTarefa;
    private String tituloTarefa;
    private String descricaoTarefa;
    private String dataConclusaoTarefa;

    public Tarefa() {
    }

    public int getIdTarefa() {
        return idTarefa;
    }

    public void setIdTarefa(int idTarefa) {
        this.idTarefa = idTarefa;
    }

    public String getTituloTarefa() {
        return tituloTarefa;
    }

    public void setTituloTarefa(String tituloTarefa) {
        this.tituloTarefa = tituloTarefa;
    }

    public String getDescricaoTarefa() {
        return descricaoTarefa;
    }

    public void setDescricaoTarefa(String descricaoTarefa) {
        this.descricaoTarefa = descricaoTarefa;
    }

    public String getDataConclusaoTarefa() {
        return dataConclusaoTarefa;
    }

    public void setDataConclusaoTarefa(String dataConclusaoTarefa) {
        this.dataConclusaoTarefa = dataConclusaoTarefa;
    }
}
