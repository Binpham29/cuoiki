package com.orishop.controller;

import com.orishop.entity.User;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chuyển hướng sang trang login.jsp
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            // Kiểm tra username và password trong DB
            String jpql = "SELECT u FROM User u WHERE u.username = :user AND u.password = :pass";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("user", u);
            query.setParameter("pass", p);

            List<User> list = query.getResultList();

            if (!list.isEmpty()) {
                User user = list.get(0);

                // Lưu thông tin người dùng vào Session
                HttpSession session = req.getSession();
                session.setAttribute("currentUser", user);

                // Nếu là Admin thì vào trang quản trị, ngược lại về trang chủ
                if (user.getIsAdmin()) {
                    resp.sendRedirect(req.getContextPath() + "/admin");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            } else {
                req.setAttribute("message", "Sai tài khoản hoặc mật khẩu!");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Lỗi kết nối: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } finally {
            if (em != null)
                em.close();
            if (emf != null)
                emf.close();
        }
    }
}