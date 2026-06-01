package controller;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListProductServlet",
            urlPatterns = {"/timsanpham"})
public class ListProductServlet extends HttpServlet {

 
    @Override
    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO dao = new ProductDAO();

        String keyword = request.getParameter("q");

        List<Product> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.searchProduct(keyword);
        } else {
            list = dao.getAllProducts();
        }

        request.setAttribute("listProduct", list);

        request.getRequestDispatcher("/index.jsp")
               .forward(request, response);
    }
}