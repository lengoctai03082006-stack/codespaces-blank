package controller;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListProductServlet", urlPatterns = {"/timsanpham"})
public class ListProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cấu hình đọc chữ tiếng Việt có dấu từ ô tìm kiếm không lỗi font
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ProductDAO dao = new ProductDAO();
        String keyword = request.getParameter("q"); // Đọc từ khóa từ ô input name="q"

        List<Product> list;

        // Nếu người dùng có nhập từ khóa thì thực hiện tìm kiếm, ngược lại lấy toàn bộ sản phẩm
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.searchProduct(keyword.trim());
        } else {
            list = dao.getAllProducts();
        }

        // Đẩy list kết quả vào Attribute gửi sang trang JSP
        request.setAttribute("listProduct", list);

        // Gọi đồng bộ chuyển tiếp sang file products.jsp
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu hệ thống phát sinh yêu cầu POST, tự động điều hướng về hàm GET để xử lý tập trung
        doGet(request, response);
    }
}