
package JavaServlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import java.util.*;

public class Description extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        ProductBean pb = (ProductBean)session.getAttribute("currentProduct");
        
        ArrayList<String> pName = new ArrayList<String>();
        ArrayList<String> pID = new ArrayList<String>();
        ArrayList<String> pImage = new ArrayList<String>();
        List<Integer> price = new ArrayList<>();
        
        pName = pb.getNameData();
        pID = pb.getIdData();
        pImage = pb.getImageData();
        price = pb.getPriceData();
        
        for(int i=0;i<pb.getProductCount();i++) {
            if(request.getParameter("product"+i+"") != null) {
                System.out.println("Button pressed: "+i+"th");
                pb.setProductID(pID.get(i));
                pb.setProductImage(pImage.get(i));
                pb.setProductName(pName.get(i));
                pb.setProductPrice(price.get(i));
            }
        }
        
        response.sendRedirect("userSingle.jsp");
    }
}
