package com.training.saleannouncements.repositories;

import com.training.saleannouncements.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findAllByTitleContainingIgnoreCase(String title);
}
