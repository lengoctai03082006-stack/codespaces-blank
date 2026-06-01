package dao;

import context.DBContext;
import model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public ProductDAO() {
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProducts() {

        List<Product> list = new ArrayList<>();

        String sql =
                "SELECT ProductID, ProductName, "
                + "SupplierID, CategoryID, "
                + "QuantityPerUnit, UnitPrice, UnitsInStock "
                + "FROM Products";

        try {

            conn = new DBContext().getConnection();

            ps = conn.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Product p = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("SupplierID"),
                        rs.getInt("CategoryID"),
                        rs.getString("QuantityPerUnit"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("UnitsInStock")
                );

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //-----------------

    public List<Product> searchProduct(String keyword) {
        List<Product> list = new ArrayList<>();

        // Đã sửa từ Text Blocks (""") thành chuỗi nối dòng thông thường
        String sql = "SELECT ProductID, "
                   + "ProductName, "
                   + "UnitPrice, "
                   + "UnitsInStock "
                   + "FROM Products "
                   + "WHERE ProductName LIKE ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");

            rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setProductID(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setUnitPrice(rs.getDouble("UnitPrice"));
                p.setUnitsInStock(rs.getInt("UnitsInStock"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}