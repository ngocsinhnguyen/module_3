package com.example.demo1;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;

@WebServlet(name = "DiscountServlet", urlPatterns = "/display-discount")
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập encoding để hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1. Lấy dữ liệu từ form
        String description = request.getParameter("description");
        String priceString = request.getParameter("price");
        String percentString = request.getParameter("discount_percent");

        double listPrice = 0;
        double discountPercent = 0;

        try {
            // 2. Chuyển đổi dữ liệu sang kiểu số
            listPrice = Double.parseDouble(priceString);
            discountPercent = Double.parseDouble(percentString);

            // Kiểm tra giá trị hợp lệ
            if (listPrice < 0 || discountPercent < 0 || discountPercent > 100) {
                throw new NumberFormatException("Giá trị không hợp lệ");
            }

            // 3. Tính toán
            double discountAmount = listPrice * discountPercent * 0.01;
            double discountPrice = listPrice - discountAmount;

            // 4. Format tiền tệ
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(Locale.US);
            String formattedListPrice = currencyFormatter.format(listPrice);
            String formattedDiscountAmount = currencyFormatter.format(discountAmount);
            String formattedDiscountPrice = currencyFormatter.format(discountPrice);

            // 5. Đặt kết quả vào request
            request.setAttribute("description", description);
            request.setAttribute("listPrice", formattedListPrice);
            request.setAttribute("discountPercent", discountPercent);
            request.setAttribute("discountAmount", formattedDiscountAmount);
            request.setAttribute("discountPrice", formattedDiscountPrice);

            // 6. Chuyển hướng đến trang kết quả
            RequestDispatcher dispatcher = request.getRequestDispatcher("/result.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi người dùng nhập sai
            request.setAttribute("error",
                    "Vui lòng nhập số hợp lệ. Giá phải >= 0, Chiết khấu từ 0-100%.");
            request.setAttribute("description", description);
            request.setAttribute("price", priceString);
            request.setAttribute("discount_percent", percentString);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect về trang chủ nếu người dùng truy cập bằng GET
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}