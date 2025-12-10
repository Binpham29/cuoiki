package com.orishop.controller;

import com.orishop.entity.User;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // 1. Kiểm tra mật khẩu nhập lại
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            // 2. Kiểm tra xem Username đã tồn tại chưa
            String checkSql = "SELECT u FROM User u WHERE u.username = :uid";
            TypedQuery<User> query = em.createQuery(checkSql, User.class);
            query.setParameter("uid", username);
            List<User> list = query.getResultList();

            if (!list.isEmpty()) {
                // Nếu đã có người dùng tên đó
                req.setAttribute("error", "Tài khoản này đã tồn tại!");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
            } else {
                // 3. Tạo tài khoản mới
                em.getTransaction().begin();
                User newUser = new User();
                newUser.setUsername(username);
                newUser.setPassword(password);
                newUser.setFullname(fullname);
                newUser.setIsAdmin(false); // Mặc định đăng ký là Khách hàng (User)

                em.persist(newUser);
                em.getTransaction().commit();

                // 4. Đăng ký thành công -> Chuyển qua trang Login
                req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } finally {
            em.close();
            emf.close();
        }
    }
}