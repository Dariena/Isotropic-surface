package controller;

import controller.command.*;
import org.jzy3d.analysis.AnalysisLauncher;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Optional;

public class Servlet extends HttpServlet {

    private HashMap<String, Command> commands = new HashMap<String, Command>();


    @Override
    public void init() throws ServletException {
        commands.put("graphic", new Bezier());
        commands.put("example", new Example());
        commands.put("home", new Home());
        commands.put("modeling", new Modeling());
        commands.put("koef", new Bezier());

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            processRequest(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            processRequest(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        String path = req.getRequestURI();
        path = path.replaceAll(".*/app/", "");
        String page = getPage(path, req);
        if (page.contains("redirect")) {
            resp.sendRedirect(page.replace("redirect:", ""));

        } else {
            req.getRequestDispatcher(page).forward(req, resp);
        }
    }

    private String getPage(String path, HttpServletRequest req) throws Exception {
        String result = req.getContextPath();
        Optional<Command> command = Optional.ofNullable(commands.get(path));
        if (command.isPresent()) {
            result = command.get().execute(req);
        }
        return result;
    }

}
