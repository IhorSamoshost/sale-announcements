package com.training.saleannouncements.controllers;

import com.training.saleannouncements.domain.Product;
import com.training.saleannouncements.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;

@RequiredArgsConstructor
@Controller
@RequestMapping("products")
public class ProductController {

    private final ProductService productService;

    @GetMapping
    public String list(@RequestParam(name = "title", required = false) String title, Model model, Principal principal) {
        model.addAttribute("products", productService.productList(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "products";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("seller", product.getUser());
        return "product";
    }

    @PostMapping
    public String create(@RequestParam(name = "file1", required = false) MultipartFile file1,
                         @RequestParam(name = "file2", required = false) MultipartFile file2,
                         @RequestParam(name = "file3", required = false) MultipartFile file3,
                         Product product,
                         Principal principal) throws IOException {
        productService.saveProduct(principal, product, Arrays.asList(file1, file2, file3));
        return "redirect:/products";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }
}
