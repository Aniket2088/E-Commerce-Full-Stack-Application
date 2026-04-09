// ══════════════════════════════════════════════════════════════════
// OrderItem.java   — missing entity, add this to your entity package
// ══════════════════════════════════════════════════════════════════
package com.aniket.ecommerce.entity;

import javax.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "order_item")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    /** How many units the user bought */
    private int quantity;

    /** Price snapshot at the time of purchase — so price changes don't affect history */
    private double priceAtTime;

    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", quantity=" + quantity +
                ", priceAtTime=" + priceAtTime +
                '}';
    }
}