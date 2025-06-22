package Servlets;

import DAOs.DAOTarefa;
import Entidades.Tarefa;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "TimerControl", urlPatterns = {"/TimerControl"})
public class TimerControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String taskId = request.getParameter("taskId");
        HttpSession session = request.getSession();
        
        // Obtém ou cria o mapa de timers na sessão
        Map<String, TimerData> timers = (Map<String, TimerData>) session.getAttribute("taskTimers");
        if (timers == null)
        {
            timers = new HashMap<>();
            session.setAttribute("taskTimers", timers);
        }
        
        DAOTarefa daoTarefa = new DAOTarefa();
        
        try (PrintWriter out = response.getWriter())
        {
            if ("start".equals(action))
            {
                // Inicia o timer para a tarefa
                TimerData timerData = new TimerData();
                timerData.setStartTime(new Date());
                timers.put(taskId, timerData);
                
                out.print("{\"status\": \"started\", \"taskId\": \"" + taskId + "\"}");
            } 
            else if ("stop".equals(action))
            {
                // Para o timer e calcula o tempo decorrido
                TimerData timerData = timers.get(taskId);
                if (timerData != null)
                {
                    timerData.setEndTime(new Date());
                    long elapsedTime = timerData.getElapsedTime();
                    
                    // Atualiza o tempo total na tarefa no banco de dados
                    Tarefa tarefa = daoTarefa.obter(Integer.parseInt(taskId));
                    if (tarefa != null)
                    {
                        float currentTime = tarefa.getTempoGasto() != null ? tarefa.getTempoGasto() : 0;
                        tarefa.setTempoGasto(currentTime + (elapsedTime / 3600.0f)); // Convertendo segundos para horas
                        daoTarefa.atualizar(tarefa); // Usando alterar em vez de inserir
                    }
                    
                    // Remove o timer da sessão
                    timers.remove(taskId);
                    
                    out.print("{\"status\": \"stopped\", \"taskId\": \"" + taskId + "\", \"elapsed\": " + elapsedTime + "}");
                } 
                else
                {
                    out.print("{\"status\": \"error\", \"message\": \"Timer não encontrado\"}");
                }
            }
            else
            {
                out.print("{\"status\": \"error\", \"message\": \"Ação inválida\"}");
            }
        }
    }

    // Classe auxiliar para armazenar os dados do timer
    private static class TimerData
    {
        private Date startTime;
        private Date endTime;
        
        public long getElapsedTime()
        {
            if (startTime != null && endTime != null)
            {
                return (endTime.getTime() - startTime.getTime()) / 1000; // Retorna em segundos
            }
            return 0;
        }

        public void setStartTime(Date startTime)
        {
            this.startTime = startTime;
        }

        public void setEndTime(Date endTime)
        {
            this.endTime = endTime;
        }
    }
}