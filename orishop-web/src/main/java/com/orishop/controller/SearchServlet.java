package com.orishop.controller;

import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 1. Lấy từ khóa người dùng nhập
        String keyword = req.getParameter("keyword");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            // 2. Viết câu lệnh tìm kiếm (Dùng LIKE)
            // %keyword% nghĩa là tìm chữ nằm ở bất cứ đâu trong tên
            String jpql = "SELECT p FROM Product p WHERE p.name LIKE :kw";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);

            // Đặt tham số cho :kw
            query.setParameter("kw", "%" + keyword + "%");

            List<Product> list = query.getResultList();

            // 3. Gửi dữ liệu sang giao diện
            req.setAttribute("products", list);
            req.setAttribute("categoryName", "Kết quả tìm kiếm: " + keyword); // Tận dụng biến này để hiện tiêu đề

            // Tái sử dụng giao diện category.jsp để hiển thị kết quả
            req.getRequestDispatcher("/views/category.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
}