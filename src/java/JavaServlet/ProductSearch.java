
package JavaServlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;


public class ProductSearch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);                                // Getting the current session object
        ProductBean pb = (ProductBean)session.getAttribute("currentProduct");           // Retrieving the ProductBean object from session
        
        if(request.getParameter("prosearch") != null) {             // If Search button is pressed
            String search = request.getParameter("tosearch");
            System.out.println("Colour searched: "+search);
            switch(search) {                                        // Using Switch-case to improve the colour search
            
                case "Black":
                case "black":
                case "BLACK": pb.setProductColour("Black");
                              break;
                              
                case "Red":
                case "red":
                case "RED": pb.setProductColour("Red");
                            break;
                            
                case "White":
                case "white":
                case "WHITE": pb.setProductColour("White");
                              break;
                              
                case "Pink":
                case "pink":
                case "PINK": pb.setProductColour("Pink");
                             break;
                             
                default: pb.setProductColour(search);
                         break;
            }
            
            response.sendRedirect("userShopSearch.jsp");            // Redirecting to searched page with having product colour
        }
        
    }

}
