
package JavaServlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;

/**
 *
 * @author sureshkumar
 */
public class UserCart extends HttpServlet {
    
    static Connection currentCon = null;
    static ResultSet rs = null;

 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        if(request.getParameter("toCart") != null) {                   // IF ADD PRODUCT BUTTON IS PRESSED IN JSP
            HttpSession session = request.getSession(false);
            UserBean usr = (UserBean)session.getAttribute("currentSessionUser");       // Getting the UserBean object from session
            ProductBean pb = (ProductBean)session.getAttribute("currentProduct");      // Getting the ProductBean object from session
            String ID = usr.getCustomerID();                // Getting customerID from UserBean
            String count = request.getParameter("quantity");
            int quantity = Integer.parseInt(count);
            System.out.println("Quantity: "+quantity);
            String product = pb.getProductID();           // Getting the current selected productID from ProductBean
            try {
                //connect to DB
                currentCon = ConnectionManager.getConnection();
                // Retrieving the Product details from Table using ProductID
                PreparedStatement ps1 = currentCon.prepareStatement("SELECT * FROM Products WHERE ProductID='"+product+"'");
                rs = ps1.executeQuery();
                rs.next();
                String productName = rs.getString(2);
                int productPrice = rs.getInt(3);
                
//                 Making an entry into Cart
                PreparedStatement ps2 = currentCon.prepareStatement("SELECT * FROM MyCart WHERE CustomerID='"+ID+"'");
                rs = ps2.executeQuery();
                boolean operation = rs.next();
                
                // FOR RETURNING CUSTOMER
                if(operation){
                    PreparedStatement pst = currentCon.prepareStatement("SELECT * FROM MyCart WHERE CustomerID='"+ID+"' AND ProductID='"+product+"'");
                    rs = pst.executeQuery();
                    if(rs.next()) {                 // IF THE PRODUCT IS ALREADY THERE AND QUANTITY NEEDED TO BE UPDATED
                            int storedUnits = rs.getInt(5);
                            int updatedUnits = storedUnits + quantity;
                            PreparedStatement ps = currentCon.prepareStatement("UPDATE MyCart SET Quantity='"+updatedUnits+"' WHERE CustomerID='"+ID+"' AND ProductID='"+product+"'");
                            int i = ps.executeUpdate();
                            if(i>0) {
                                System.out.println("Updated!");
                                response.sendRedirect("userCart.jsp");
                            }
                    }
                    else {                         // IF THE PRODUCT IS NEW AND NEED TO BE REGISTERED
                            PreparedStatement ps3 = currentCon.prepareStatement("INSERT INTO MyCart VALUES (?,?,?,?,?)");
                            ps3.setString(1, ID);
                            ps3.setString(2, product);
                            ps3.setString(3, productName);
                            ps3.setInt(4, productPrice);
                            ps3.setInt(5, quantity);
                            int i = ps3.executeUpdate();
                            if(i>0) {
                                System.out.println("Registered!");
                                response.sendRedirect("userCart.jsp");
                            }
                    }
                }
                
                // FOR FIRST TIME CUSTOMERS
                else {       
                    PreparedStatement ps3 = currentCon.prepareStatement("INSERT INTO MyCart VALUES (?,?,?,?,?)");
                    ps3.setString(1, ID);
                    ps3.setString(2, product);
                    ps3.setString(3, productName);
                    ps3.setInt(4, productPrice);
                    ps3.setInt(5, quantity);
                    int i = ps3.executeUpdate();
                    if(i>0) {
                        System.out.println("Registered!");
                        response.sendRedirect("userCart.jsp");
                    } 
                }
            }
            catch(SQLException ex) {
                System.out.println("Connection Error in Add: ");
                ex.printStackTrace();
            }
        }
    }
}
