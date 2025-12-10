package com.orishop.controller;

import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Tạo list rỗng trước để tránh lỗi Null
        List<Product> list = new ArrayList<>();

        EntityManagerFactory emf = null;
        EntityManager em = null;

        try {
            // 2. Thử kết nối và lấy dữ liệu
            emf = Persistence.createEntityManagerFactory("OrishopPU");
            em = emf.createEntityManager();

            TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p", Product.class);
            list = query.getResultList();

        } catch (Exception e) {
            // 3. Nếu lỗi, in ra Log để sửa, nhưng KHÔNG dừng chương trình
            e.printStackTrace();
            System.out.println("LỖI KẾT NỐI DB: " + e.getMessage());
        } finally {
            if (em != null)
                em.close();
            if (emf != null)
                emf.close();
        }

        // 4. BẮT BUỘC: Đặt lệnh chuyển hướng Ở NGOÀI try/catch
        req.setAttribute("products", list);

        // Lưu ý: Dựa vào ảnh của bạn, file đang ở trong thư mục views
        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}