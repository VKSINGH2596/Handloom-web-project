
package JavaServlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Random;


public class Register extends HttpServlet {

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF");
        PrintWriter out = response.getWriter();
	
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String pass = request.getParameter("pass");
        
        try {

            // loading drivers for mysql
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database 
            Connection con = ConnectionManager.getConnection();
            boolean check;
            String ID = null;
            do {                                    // Loop for checking and creating a unique customer ID
                String checkID = uniqueID();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Details WHERE CustomerID='"+checkID+"'");
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    check = false;
                }
                else {
                    check = true;
                    ID = checkID;
                }
            }while(check == false);

            PreparedStatement ps1 = con.prepareStatement("INSERT INTO Details VALUES(?,?,?,?,?)");

            ps1.setString(1, name);
            ps1.setString(2, email);
            ps1.setString(3, phone);
            ps1.setString(4, pass);
            ps1.setString(5, ID);
            int i = ps1.executeUpdate();
            if(i > 0) {
            out.println("You are sucessfully registered");
            RequestDispatcher rd = request.getRequestDispatcher("login.html");
            rd.forward(request,response);
            }

        }
        catch(Exception e) 
            {  
                out.println("error");
                RequestDispatcher rd = request.getRequestDispatcher("register.html");
                rd.include(request, response);
            }
        }
	
    
    public String uniqueID() {
        String customerID = null;
        Random rnd = new Random();
        int n = 100000 + rnd.nextInt(900000);  // Generating random 6-digit no. between 100000-999999
        customerID = "CID"+n;
        System.out.println("ID: "+customerID);
        return customerID;
    }
}
