package com.training.saleannouncements.services;

import com.training.saleannouncements.domain.User;
import com.training.saleannouncements.domain.enums.Role;
import com.training.saleannouncements.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Slf4j
@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean create(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) {
            return false;
        }
        user.setActive(true);
        user.getRoles().add(Role.ROLE_USER);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        log.info("User {} was saved under id: {}", email, user.getId());
        return true;
    }

    public List<User> getAll() {
        return userRepository.findAll();
    }

    public void changeUserActiveStatus(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(!user.isActive());
            if (user.isActive()) {
                log.info("User with id = {} was unbanned", user.getId());
            } else {
                log.info("User with id = {} was banned", user.getId());
            }
            userRepository.save(user);
        }
    }

    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        form.keySet().stream()
                .filter(roles::contains)
                .forEach(key -> user.getRoles().add(Role.valueOf(key)));
        userRepository.save(user);
        log.info("Roles of currentUser with id = {} was changed", user.getId());
    }

    public User getUserByPrincipal(Principal principal) {
        return principal != null ? userRepository.findByEmail(principal.getName()) : new User();
    }
}
