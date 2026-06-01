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
        
        // 1. Cấu hình đọc chữ tiếng Việt có dấu từ ô tìm kiếm không lỗi font
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        ProductDAO dao = new ProductDAO();
        String keyword = request.getParameter("q"); // Đọc từ khóa từ ô input name="q"
        
        // Nhận thêm tham số danh mục từ các thẻ tab nút bấm nếu có (?category=...)
        String category = request.getParameter("category"); 

        List<Product> list;

        // 2. Kiểm tra và chuẩn hóa từ khóa gõ từ ô Tìm kiếm
        if (keyword == null) {
            keyword = "";
        }
        String keyLower = keyword.trim().toLowerCase();

        // LOGIC THÔNG MINH: Nếu gõ từ khóa phân loại tiếng Việt, lấy toàn bộ sản phẩm để JSP tự lọc
        if (keyLower.equals("trà") || keyLower.equals("tra") 
                || keyLower.equals("trái cây") || keyLower.equals("trai cay") 
                || keyLower.equals("gia vị") || keyLower.equals("gia vi")
                || keyLower.equals("quả") || keyLower.equals("qua")
                || keyLower.equals("sốt") || keyLower.equals("sot")
                || keyLower.equals("mứt") || keyLower.equals("mut")) {
            
            list = dao.getAllProducts(); // Lấy tất cả danh sách sản phẩm gốc về
            
        } else if (!keyword.trim().isEmpty()) {
            // Trường hợp gõ tên sản phẩm cụ thể bằng tiếng Anh (Ví dụ: "Chai", "Chang", "Chef"...)
            list = dao.searchProduct(keyword.trim());
        } else {
            // Nếu ô tìm kiếm rỗng, mặc định lấy toàn bộ sản phẩm
            list = dao.getAllProducts();
        }

        // 3. Đẩy list kết quả và từ khóa ngược lại Attribute để gửi sang trang JSP
        request.setAttribute("listProduct", list);
        request.setAttribute("selectedCat", category); // Giữ trạng thái tab đang chọn

        // 4. Gọi đồng bộ chuyển tiếp sang file products.jsp
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu hệ thống phát sinh yêu cầu POST, tự động điều hướng về hàm GET để xử lý tập trung
        doGet(request, response);
    }
}