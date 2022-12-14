package com.training.saleannouncements.services;

import com.training.saleannouncements.domain.Image;
import com.training.saleannouncements.domain.Product;
import com.training.saleannouncements.domain.User;
import com.training.saleannouncements.repositories.ProductRepository;
import com.training.saleannouncements.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Slf4j
@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Product> productList(String title, String city) {
        return (title != null && !title.isBlank()) && (city != null && !city.isBlank()) ?
                productRepository.findAllByTitleContainingIgnoreCaseAndCityContainingIgnoreCase(title, city) :
                (title != null && !title.isBlank()) && (city == null || city.isBlank()) ?
                        productRepository.findAllByTitleContainingIgnoreCase(title) :
                        (title == null || title.isBlank()) && (city != null && !city.isBlank()) ?
                                productRepository.findAllByCityContainingIgnoreCase(city) :
                                productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product, List<MultipartFile> imageFiles) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        Image image;
        if (!product.getTitle().isBlank() && product.getPrice() != null) {
            for (int i = 0; i < imageFiles.size(); i++) {
                if (imageFiles.get(i).getSize() != 0) {
                    image = toImageEntity(imageFiles.get(i));
                } else continue;
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

    public List<String> getAllProductCities() {
        return productList(null, null).stream().map(Product::getCity).distinct().collect(Collectors.toList());
    }
}
