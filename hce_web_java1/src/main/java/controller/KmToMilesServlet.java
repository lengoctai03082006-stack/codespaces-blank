package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/chuyendoi")
public class KmToMilesServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        double km = Double.parseDouble(request.getParameter("km"));

        double miles = km * 0.621371;

        request.setAttribute("result", miles);

        request.getRequestDispatcher("doikm.jsp")
               .forward(request, response);
    }
}