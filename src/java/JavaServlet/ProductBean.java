
package JavaServlet;
import java.util.*;

public class ProductBean {
    
    private String productID;
    private String productName;
    private int productPrice;
    private String productImage;
    private String productColour;
    private int productCount;
    private ArrayList<String> name = new ArrayList<String>();
    private ArrayList<String> coll_image = new ArrayList<String>();
    private ArrayList<String> id = new ArrayList<String>();
    private ArrayList<String> desc_image = new ArrayList<String>();
    private ArrayList<String> colour = new ArrayList<String>();
    private List<Integer> price = new ArrayList<>();
    
    public void setProductID(String iD) {
        productID = iD;
    }
    
    public String getProductID() {
        return productID;
    }
    
    public void setProductName(String name) {
        productName = name;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductPrice(int price) {
        productPrice = price;
    }
    
    public int getProductPrice() {
        return productPrice;
    }
    
    public void setProductImage(String imageRef) {
        productImage = imageRef;
    }
    
    public String getProductImage() {
        return productImage;
    }
    
    public void setProductCount(int count) {
        productCount = count;
    }
    
    public int getProductCount() {
        return productCount;
    }
    
    public void setProductColour(String userColour) {
        productColour = userColour;
    }
    
    public String getProductColour() {
        return productColour;
    }
    
    public void setTableData(ArrayList<String> pName, ArrayList<String> pImage, ArrayList<String> pImage1, ArrayList<String> pColour, ArrayList<String> piD, List<Integer> proPrice) {
        name = pName;
        coll_image = pImage;
        desc_image = pImage1;
        colour = pColour;
        id = piD;
        price = proPrice;
    }
    
    public ArrayList<String> getNameData() {
        return name;
    }
    
    public ArrayList<String> getThumbData() {
        return coll_image;
    }
    
    public ArrayList<String> getImageData() {
        return desc_image;
    }
    
    public ArrayList<String> getImageColor() {
        return colour;
    }
    
    public ArrayList<String> getIdData() {
        return id;
    }

    public List<Integer> getPriceData() {
        return price;
    }
}
