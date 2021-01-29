
package JavaServlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;


public class Logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        UserBean usrbn = (UserBean)(session.getAttribute("currentSessionUser"));
        
        if(request.getParameter("lgout") == null) {
            System.out.println("Button Error!");
        }
        else {
            usrbn.setValid(false);
            session.invalidate();
            response.sendRedirect("login.html");
        }
    }

    
}
