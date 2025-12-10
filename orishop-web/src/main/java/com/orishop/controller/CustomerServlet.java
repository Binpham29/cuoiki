package com.orishop.controller;

import com.orishop.entity.User;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer-manage")
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idStr = req.getParameter("id");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            if ("delete".equals(action) && idStr != null) {
                // --- XÓA KHÁCH HÀNG ---
                em.getTransaction().begin();
                User u = em.find(User.class, Integer.parseInt(idStr));
                if (u != null) {
                    em.remove(u);
                }
                em.getTransaction().commit();
                resp.sendRedirect(req.getContextPath() + "/customer-manage");

            } else if ("edit".equals(action) && idStr != null) {
                // --- HIỆN FORM SỬA ---
                User u = em.find(User.class, Integer.parseInt(idStr));
                req.setAttribute("user", u);
                req.getRequestDispatcher("/admin/customer-form.jsp").forward(req, resp);

            } else if ("create".equals(action)) {
                // --- HIỆN FORM THÊM MỚI ---
                req.getRequestDispatcher("/admin/customer-form.jsp").forward(req, resp);

            } else {
                // --- MẶC ĐỊNH: HIỆN DANH SÁCH ---
                TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
                List<User> list = query.getResultList();

                req.setAttribute("customers", list);
                req.getRequestDispatcher("/admin/customers.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String roleStr = req.getParameter("isAdmin"); // Trả về "true" hoặc null

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            User u;

            if (idStr != null && !idStr.isEmpty()) {
                // Sửa
                u = em.find(User.class, Integer.parseInt(idStr));
                u.setUsername(username);
                u.setPassword(password);
                u.setFullname(fullname);
                u.setIsAdmin(roleStr != null); // Checkbox được chọn là true
                em.merge(u);
            } else {
                // Thêm mới
                u = new User();
                u.setUsername(username);
                u.setPassword(password);
                u.setFullname(fullname);
                u.setIsAdmin(roleStr != null);
                em.persist(u);
            }

            em.getTransaction().commit();
            resp.sendRedirect(req.getContextPath() + "/customer-manage");

        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
}