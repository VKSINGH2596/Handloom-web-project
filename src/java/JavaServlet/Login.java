
package JavaServlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;


public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
      
        UserBean user = new UserBean();
        user.setUserEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        
        
        user = UserDAO.login(user);
        
        if(user.isValid()) {
            
            try {
                ProductBean product = new ProductBean();             // Creating object for ProjectBean class
                // BELOW CREATING ARRAYLISTs TO STORE THE PRODUCTS DETAILS FROM TABLE
                String query = "SELECT * FROM Products";             
                Connection con = ConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                
                ArrayList<String> proname = new ArrayList<String>();
                ArrayList<String> proimg1 = new ArrayList<String>();
                ArrayList<String> proimg2 = new ArrayList<String>();
                ArrayList<String> proid = new ArrayList<String>();
                ArrayList<String> procolour = new ArrayList<String>();
                List<Integer> proprice = new ArrayList<>();
                
                while(rs.next()) {
                    proname.add(rs.getString("Name"));
                    proimg1.add(rs.getString("Image"));
                    proimg2.add(rs.getString("Image1"));
                    procolour.add(rs.getString("Colour"));
                    proid.add(rs.getString("ProductID"));
                    proprice.add(rs.getInt("Price"));
                }
                
                product.setProductCount(proname.size());                           // Storing the size of the arraylist
                product.setTableData(proname, proimg1, proimg2, procolour, proid, proprice);             // Storing all the data in ProductBean class
                HttpSession session = request.getSession(true);
                session.setAttribute("currentSessionUser",user);
                session.setAttribute("currentProduct", product);
                response.sendRedirect("userLogged.jsp");
            }
            catch(SQLException e) {
                e.printStackTrace();
            }
        }
        else {
            out.println("Email or Password is Incorrect!");
            RequestDispatcher rd = request.getRequestDispatcher("login.html");
            rd.include(request, response);
        }
    }
}
