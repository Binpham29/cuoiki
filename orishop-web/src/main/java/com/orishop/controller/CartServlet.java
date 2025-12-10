package com.orishop.controller;

import com.orishop.entity.CartItem;
import com.orishop.entity.Product;
import com.orishop.entity.User; // Nhớ import User
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idStr = req.getParameter("id");

        // 1. Lấy giỏ hàng từ Session
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // 2. Xử lý các hành động
        if ("add".equals(action) && idStr != null) {

            // --- [QUAN TRỌNG] KIỂM TRA ĐĂNG NHẬP ---
            User currentUser = (User) session.getAttribute("currentUser");

            if (currentUser == null) {
                // Nếu chưa đăng nhập -> Chuyển hướng sang trang Login
                // (Có thể thêm thông báo "Vui lòng đăng nhập để mua hàng")
                req.setAttribute("message", "Vui lòng đăng nhập để mua hàng!");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return; // Dừng lại, không chạy code thêm giỏ hàng bên dưới
            }
            // ----------------------------------------

            // --- NẾU ĐÃ ĐĂNG NHẬP THÌ CHẠY TIẾP ĐOẠN NÀY ---
            int productId = Integer.parseInt(idStr);
            boolean found = false;

            // Kiểm tra xem sản phẩm đã có trong giỏ chưa
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1); // Tăng số lượng
                    found = true;
                    break;
                }
            }

            // Nếu chưa có, lấy từ DB và thêm mới vào giỏ
            if (!found) {
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
                EntityManager em = emf.createEntityManager();
                try {
                    Product p = em.find(Product.class, productId);
                    if (p != null) {
                        cart.add(new CartItem(p, 1));
                    }
                } finally {
                    em.close();
                    emf.close();
                }
            }

            // Lưu lại vào Session
            session.setAttribute("cart", cart);

            // Quay lại trang trước đó
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer != null ? referer : "home");

        } else if ("remove".equals(action) && idStr != null) {
            // --- XÓA SẢN PHẨM (Không cần đăng nhập vẫn cho xóa) ---
            int productId = Integer.parseInt(idStr);
            cart.removeIf(item -> item.getProduct().getId() == productId);

            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getContextPath() + "/cart?action=view");

        } else {
            // --- XEM GIỎ HÀNG (Mặc định) ---
            double totalMoney = 0;
            for (CartItem item : cart) {
                totalMoney += item.getTotalPrice();
            }
            req.setAttribute("totalMoney", totalMoney);

            req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
        }
    }
}