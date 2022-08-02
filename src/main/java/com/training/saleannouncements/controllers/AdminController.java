package com.training.saleannouncements.controllers;

import com.training.saleannouncements.domain.User;
import com.training.saleannouncements.domain.enums.Role;
import com.training.saleannouncements.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Map;

@Controller
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
@RequiredArgsConstructor
public class AdminController {
    private final UserService userService;

    @GetMapping("/admin")
    public String adminPanel(Model model, Principal principal) {
        model.addAttribute("users", userService.getAll());
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "admin-panel";
    }

    @PostMapping("/admin/users/ban/{id}")
    public String changeBanStatus(@PathVariable Long id) {
        userService.changeUserActiveStatus(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/users/edit/{user}")
    public String edit(@PathVariable User user, Model model, Principal principal) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        model.addAttribute("currentUser", userService.getUserByPrincipal(principal));
        return "user-edit";
    }

    @PostMapping("/admin/users/edit")
    public String updateRoles(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.changeUserRoles(user, form);
        return "redirect:/admin";
    }
}
