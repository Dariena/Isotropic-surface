package controller.command;

import model.Main;
import model.Quadratic;
import org.jzy3d.analysis.AnalysisLauncher;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

public class Bezier implements Command {
    private HashMap<String, Double> dots = new HashMap<>();

    @Override
    public String execute(HttpServletRequest request) throws Exception {
        try {
            dots.put("a0", Double.parseDouble(request.getParameter("a0")));
            dots.put("a1", Double.parseDouble(request.getParameter("a1")));
            dots.put("a2", Double.parseDouble(request.getParameter("a2")));
            dots.put("a3", Double.parseDouble(request.getParameter("a3")));
            dots.put("a0im", Double.parseDouble(request.getParameter("a0im")));
            dots.put("a1im", Double.parseDouble(request.getParameter("a1im")));
            dots.put("a2im", Double.parseDouble(request.getParameter("a2im")));
            dots.put("a3im", Double.parseDouble(request.getParameter("a3im")));
            dots.put("k", Double.parseDouble(request.getParameter("k")));
        }
        catch (NumberFormatException e){
            return "/indexWithEx.jsp";
        }
        if(request.getParameter("ok").equals("Create your surface")){
        AnalysisLauncher.open(new Main(dots));}
        else if(request.getParameter("ok").equals("Create e")){
            AnalysisLauncher.open(new Quadratic(dots));
        }
        return "/index.jsp";
    }


}
