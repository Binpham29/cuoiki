package com.orishop.entity;

import javax.persistence.*;

@Entity
@Table(name = "Products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", columnDefinition = "NVARCHAR(100)")
    private String name;

    @Column(name = "price")
    private Double price;

    @Column(name = "image")
    private String image;

    @Column(name = "category")
    private String category;

    // --- MỚI THÊM: Cột giảm giá ---
    @Column(name = "discount")
    private Integer discount = 0; // Mặc định là 0 (không giảm)

    // Constructor rỗng (Bắt buộc cho JPA)
    public Product() {
    }

    public Product(String name, Double price, String image, String category, Integer discount) {
        this.name = name;
        this.price = price;
        this.image = image;
        this.category = category;
        this.discount = discount;
    }

    // --- Getters và Setters ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // --- Getter và Setter cho Discount ---
    public Integer getDiscount() {
        return discount != null ? discount : 0;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    // --- QUAN TRỌNG: Hàm tính giá sau khi giảm (Sale Price) ---
    // Web sẽ gọi hàm này bằng cách dùng: ${p.salePrice}
    public Double getSalePrice() {
        if (this.discount == null || this.discount == 0) {
            return this.price; // Nếu không giảm thì trả về giá gốc
        }
        // Công thức: Giá gốc * (100 - %giảm) / 100
        return this.price * (100 - this.discount) / 100.0;
    }
}