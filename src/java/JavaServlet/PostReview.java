
package JavaServlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.*;


public class PostReview extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        //If the Submit button is pressed
        if(request.getParameter("normalpost") != null) {
            
            String postName = request.getParameter("postname");
            String postProID = request.getParameter("postid");
            String postRating = request.getParameter("postrating");
            String postMessage = request.getParameter("comment");
            
            // USING THE PRODUCT ID TO FIND THE PRODUCT DETAILS AND STORING IN THE REVIEW DATABASE
            try {
                Connection con = ConnectionManager.getConnection();
                String query = "SELECT * FROM Products WHERE ProductID='"+postProID+"'";
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();                       // Creating a ResultSet class object to retrieve data
                if(rs.next()) {
                    String proName = rs.getString("Name");
                    String proImage = rs.getString("Image");
                    
                    String query1 = "INSERT INTO Reviews VALUES (?,?,?,?,?,?)";          // Finally Storing the necessary data in Review table
                    ps = con.prepareStatement(query1);
                    ps.setString(1, postName);
                    ps.setString(2, postProID);
                    ps.setString(3, postRating);
                    ps.setString(4, postMessage);
                    ps.setString(5, proName);
                    ps.setString(6, proImage);

                    int i = ps.executeUpdate();
                    if(i>0) {
                        System.out.println("Message stored!");
                        HttpSession session = request.getSession(false);
                        session.setAttribute("postReview", con);
                        
                        response.sendRedirect("userReviews.jsp");
                    }
                }
                
            }
            catch(SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
