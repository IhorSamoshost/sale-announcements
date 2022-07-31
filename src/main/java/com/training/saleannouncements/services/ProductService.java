package com.training.saleannouncements.services;

import com.training.saleannouncements.domain.Image;
import com.training.saleannouncements.domain.Product;
import com.training.saleannouncements.domain.User;
import com.training.saleannouncements.repositories.ProductRepository;
import com.training.saleannouncements.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@RequiredArgsConstructor
@Slf4j
@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Product> productList(String title) {
        if (title != null && !title.isBlank()) {
            return productRepository.findAllByTitleContainingIgnoreCase(title);
        }
        return productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product, List<MultipartFile> imageFiles) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        Image image;
        if (!product.getTitle().isBlank() && product.getPrice() != null) {
            for (int i = 0; i < imageFiles.size(); i++) {
                image = toImageEntity(imageFiles.get(i));
                if (i == 0) {
                    image.setPreviewImage(true);
                }
                product.addImage(image);
            }
            productRepository.save(product);
            product.setPreviewImageId(product.getImages().stream().filter(Image::isPreviewImage)
                    .findFirst().map(Image::getId).orElse(null));
            productRepository.save(product);
            log.info("Product with title: {} and price: {} was saved under id: {}",
                    product.getTitle(), product.getPrice(), product.getId());
        } else {
            log.info("Product with title: {} and price: {} was not saved", product.getTitle(), product.getPrice());
        }
    }

    public User getUserByPrincipal(Principal principal) {
        return principal != null ? userRepository.findByEmail(principal.getName()) : new User();
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteProduct(Long id) {
        try {
            productRepository.deleteById(id);
            log.info("Product with id = {} was deleted", id);
        } catch (Exception e) {
            log.info("Product with id = {} was not deleted", id);
        }
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
