package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "KmToMilesServlet", urlPatterns = {"/chuyendoi"})
public class KmToMilesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Vào bằng GET (hoặc link thông thường) thì chuyển thẳng đến giao diện doikm.jsp
        request.getRequestDispatcher("/doikm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Nhận diện người dùng đang bấm nút của Form nào dựa vào thuộc tính "type"
        String type = request.getParameter("type");

        if ("temperature".equals(type)) {
            // 1. XỬ LÝ CHUYỂN ĐỔI NHIỆT ĐỘ
            String celsiusStr = request.getParameter("km"); // giữ name="km" tương thích cũ
            String tempResult = "";
            try {
                if (celsiusStr != null && !celsiusStr.trim().isEmpty()) {
                    double celsius = Double.parseDouble(celsiusStr.trim());
                    double fahrenheit = (celsius * 9 / 5) + 32;
                    tempResult = celsius + " °C = " + String.format("%.2f", fahrenheit) + " °F";
                }
            } catch (NumberFormatException e) {
                tempResult = "Số độ C không hợp lệ!";
            }
            request.setAttribute("result", tempResult);
            request.setAttribute("oldCelsius", celsiusStr);

        } else if ("currency".equals(type)) {
            // 2. XỬ LÝ CHUYỂN ĐỔI USD SANG VND
            String usdStr = request.getParameter("usdAmount");
            String usdResult = "";
            try {
                if (usdStr != null && !usdStr.trim().isEmpty()) {
                    double usd = Double.parseDouble(usdStr.trim());
                    // Giả định tỷ giá cố định hiện tại là 25,450 VND / 1 USD
                    double rate = 25450; 
                    double vnd = usd * rate;
                    
                    // Định dạng số hiển thị có dấu chấm phân cách hàng nghìn
                    usdResult = "$" + usd + " USD = " + String.format("%,.0f", vnd) + " VND";
                }
            } catch (NumberFormatException e) {
                usdResult = "Số tiền USD không hợp lệ!";
            }
            request.setAttribute("currencyResult", usdResult);
            request.setAttribute("oldUsd", usdStr);
        }

        // Đồng bộ trả kết quả về lại trang doikm.jsp hiển thị công khai
        request.getRequestDispatcher("/doikm.jsp").forward(request, response);
    }
}