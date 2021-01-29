
package JavaServlet;

public class UserBean {
    
    private String userEmail;
    private String password;
    private String name;
    private String message;
    private String customerID;
    private String productID;
    private String productName;
    private int productPrice;
    private String productImage;
    public boolean valid;
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String newUserEmail) {
        userEmail = newUserEmail;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String newPassword) {
        password = newPassword;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String newName) {
        name = newName;
    }
    
    public boolean isValid() {
        return valid;
    } 
    
    public void setValid(boolean newValid) {
        valid = newValid;
    }
    
    public void setCustomerID(String iD) {
        customerID = iD;
    }
    
    public String getCustomerID() {
        return customerID;
    }
    
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
    
    public void setMessage(String text) {
        message = text;
    }
    
    public String getMessage() {
        return message;
    }
}
