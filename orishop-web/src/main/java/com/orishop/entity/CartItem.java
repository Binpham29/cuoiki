package com.orishop.entity;

public class CartItem {
    private Product product;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getter & Setter
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // --- CẬP NHẬT: Tính thành tiền theo GIÁ SALE ---
    public double getTotalPrice() {
        // Sử dụng getSalePrice() thay vì getPrice()
        // Nếu sản phẩm không giảm giá, getSalePrice() vẫn trả về giá gốc nên vẫn đúng
        return product.getSalePrice() * quantity;
    }
}