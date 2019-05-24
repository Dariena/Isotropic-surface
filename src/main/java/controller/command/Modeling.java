package controller.command;

import javax.servlet.http.HttpServletRequest;

public class Modeling implements Command {
    @Override
    public String execute(HttpServletRequest request) throws Exception {
        return "/index.jsp";
    }
}
