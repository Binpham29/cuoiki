package com.orishop.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

// Khi web gọi /image?fname=abc.jpg, Servlet này sẽ chạy
@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");

        // Đường dẫn phải KHỚP với ProductServlet
        String uploadPath = "C:\\orishop-uploads";

        if (fileName == null || fileName.equals("")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File file = new File(uploadPath + File.separator + fileName);

        if (file.exists()) {
            String contentType = getServletContext().getMimeType(file.getName());
            if (contentType == null)
                contentType = "application/octet-stream";
            resp.setContentType(contentType);
            Files.copy(file.toPath(), resp.getOutputStream());
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}