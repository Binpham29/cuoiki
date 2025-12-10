package com.orishop.controller;

import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy loại danh mục từ URL
        String type = req.getParameter("type");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            // Lọc sản phẩm theo category
            String jpql = "SELECT p FROM Product p WHERE p.category = :cat";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("cat", type);

            List<Product> list = query.getResultList();

            // Gửi dữ liệu sang trang category.jsp
            req.setAttribute("products", list);

            // Đặt tên tiêu đề cho đẹp
            String title = "Danh Sách Sản Phẩm";
            if ("Technology".equals(type))
                title = "Đồ Công Nghệ";
            else if ("Cosmetics".equals(type))
                title = "Mỹ Phẩm Chính Hãng";

            req.setAttribute("categoryName", title);

            req.getRequestDispatcher("/views/category.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (em != null)
                em.close();
            if (emf != null)
                emf.close();
        }
    }
}