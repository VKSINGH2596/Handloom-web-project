
package JavaServlet;
import java.sql.*;
import java.text.*;
import java.util.*;

public class UserDAO {
    
    static Connection currentCon = null;
    static ResultSet rs = null;
    
    public static UserBean login(UserBean bean) {
       
        //Preparing some objects for connection
        Statement stmt = null;
        
        String email = bean.getUserEmail();
        String password = bean.getPassword();
        
        String searchQuery = "SELECT * FROM Details WHERE Email='"+email+"' AND Password='"+password+"'";
        
        //For tracing the process on the console we're using System.out.println
        System.out.println("Entered Email: "+email);
        System.out.println("Entered Password: "+password);
        System.out.println("Query: "+searchQuery);
        
        try {
            //connect to DB
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            //if user does not exist set the isValid() variable to false
            if(!more) {
                System.out.println("Sorry! You are not registered user!");
                bean.setValid(false);
            }
            //if user exist set the isValid() variable to true
            else if(more) {
                String uname = rs.getString("Name");
                System.out.println("Welcome "+uname);
                bean.setCustomerID(rs.getString(5));
                bean.setName(uname);
                bean.setValid(true);
            }
        }
        catch(Exception ex) {
            System.out.println("LogIn failed: An Exception has occurred! "+ex);
        }
        
        //some exception handling
        finally 
        {
            if (rs != null)	{
                try {
                    rs.close();
                } 
                catch (Exception e) {}
                rs = null;
            }
	
            if (stmt != null) {
                try {
                    stmt.close();
                } 
                catch (Exception e) {}
                stmt = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close();
                } 
                catch (Exception e) {}
                currentCon = null;
            }
        }
        
        return bean;
    }
}
