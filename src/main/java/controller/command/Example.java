package controller.command;

import javax.servlet.http.HttpServletRequest;

public class Example implements Command {
    @Override
    public String execute(HttpServletRequest request) throws Exception {
        return "/bezier.jsp";
    }
}
