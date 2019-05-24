package controller.command;

import javax.servlet.http.HttpServletRequest;

public class Home implements Command {
    @Override
    public String execute(HttpServletRequest request) throws Exception {
        return "/home.jsp";
    }
}
