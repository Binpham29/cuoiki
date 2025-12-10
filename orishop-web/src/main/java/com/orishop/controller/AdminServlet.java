package com.orishop.controller;

import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

// Đường dẫn sẽ là /admin
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            // Lấy toàn bộ sản phẩm từ DB
            TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p", Product.class);
            List<Product> list = query.getResultList();

            // Gửi dữ liệu sang trang JSP
            req.setAttribute("products", list);

            // Chuyển hướng đến file trong thư mục admin
            req.getRequestDispatcher("/admin/index.jsp").forward(req, resp);

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