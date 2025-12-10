package com.orishop.controller;

import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/product-manage")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ... (Giữ nguyên logic doGet cũ)
        String action = req.getParameter("action");
        String idStr = req.getParameter("id");
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            if ("delete".equals(action) && idStr != null) {
                em.getTransaction().begin();
                Product p = em.find(Product.class, Integer.parseInt(idStr));
                if (p != null)
                    em.remove(p);
                em.getTransaction().commit();
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else if ("edit".equals(action) && idStr != null) {
                Product p = em.find(Product.class, Integer.parseInt(idStr));
                req.setAttribute("product", p);
                req.getRequestDispatcher("/admin/product-form.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/admin/product-form.jsp").forward(req, resp);
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

        try {
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String priceStr = req.getParameter("price");
            String category = req.getParameter("category");

            int discount = 0;
            try {
                String dParam = req.getParameter("discount");
                if (dParam != null && !dParam.isEmpty())
                    discount = Integer.parseInt(dParam);
            } catch (Exception e) {
            }

            String image = req.getParameter("currentImage");
            Part filePart = req.getPart("imageFile");

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String newFileName = System.currentTimeMillis() + "_" + fileName;

                // --- ĐÂY LÀ CHỖ QUAN TRỌNG: Lưu vào ổ C ---
                String uploadPath = "C:\\orishop-uploads";
                // ------------------------------------------

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists())
                    uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + newFileName);
                image = newFileName;
            }

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
            EntityManager em = emf.createEntityManager();

            try {
                em.getTransaction().begin();
                Product p;
                if (idStr != null && !idStr.isEmpty()) {
                    p = em.find(Product.class, Integer.parseInt(idStr));
                    p.setName(name);
                    p.setPrice(Double.parseDouble(priceStr));
                    p.setCategory(category);
                    p.setDiscount(discount);
                    if (image != null && !image.isEmpty())
                        p.setImage(image);
                    em.merge(p);
                } else {
                    p = new Product();
                    p.setName(name);
                    p.setPrice(Double.parseDouble(priceStr));
                    p.setCategory(category);
                    p.setDiscount(discount);
                    p.setImage(image);
                    em.persist(p);
                }
                em.getTransaction().commit();
                resp.sendRedirect(req.getContextPath() + "/admin");
            } catch (Exception e) {
                if (em.getTransaction().isActive())
                    em.getTransaction().rollback();
                e.printStackTrace();
            } finally {
                em.close();
                emf.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}