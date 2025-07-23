package com.project.jobportal.config;

import com.project.jobportal.components.JwtAuthenticationFilter;
import com.project.jobportal.repositories.IUserRepository;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpRequest;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;


@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {//là 1 class xử lý các config liên quan đến security;
    private final IUserRepository iUserRepository;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, JwtAuthenticationFilter jwtAuthenticationFilter) throws Exception {
        http
                .httpBasic(Customizer.withDefaults())//sử dụng BasicAuthenticationFilter
                .csrf(csrf -> csrf.disable())
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .authorizeHttpRequests(auth -> auth
                                // K cần xác thực
                                .requestMatchers("/api/v1/applicant/login",
                                        "/api/v1/recruiter/login").permitAll()
                                .requestMatchers(HttpMethod.POST,
                                        "/api/v1/applicant").permitAll()
                                .requestMatchers(HttpMethod.POST,
                                        "/api/v1/recruiter").permitAll()
                                .requestMatchers(HttpMethod.POST,
                                        "/api/v1/user/login").permitAll()
                                .requestMatchers(
                                        "/").authenticated()

                                // Truy cập với quyền admin
                                .requestMatchers("/api/v1/user/BanUser",
                                        "/api/v1/user/UNBanUser",
                                        "/api/v1/recruiterVerification/LOA/**",
                                        "/api/v1/recruiterVerification/BL/**",
                                        "/api/v1/recruiterVerification/status").hasRole("ADMIN")
                                //Chỉ cần xác thực là vào được
                                .anyRequest().hasAnyRole("ADMIN", "RECRUITER", "APPLICANT")
//                Cấu hình bộ lọc mới và chạy trước UsernamePasswordAuthenticationFileter
//                ).formLogin(Customizer.withDefaults())
//                .oauth2Login(Customizer.withDefaults());
                )
                .addFilterAfter(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public AuthenticationManager authManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class)
                .authenticationProvider(authenticationProvider())
                .build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {//xác thực thông tin đăng nhập của người dùng
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();//dùng để xác thực thông tin người dùng
        authenticationProvider.setUserDetailsService(userDetailsService());//gán userDetailService cho authenticationProvider (UserDetailService dc dn o model)
        authenticationProvider.setPasswordEncoder(passwordEncoder());//passwordEncoder bang instance nao ?
        return authenticationProvider;
    }

    @Bean// authentication
    public UserDetailsService userDetailsService() {
        return email -> iUserRepository
                .findByEmail(email)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Cannot find user with email = " + email));
    }
//    @Bean// authentication
//    public UserDetailsService userDetailsService() {
//        return new InMemoryUserDetailsManager(
//                User.builder()
//                        .username("datlogarit")
//                        .password(passwordEncoder().encode("datlogarit"))
//                        .authorities("ROLE_RECRUITER")
//                        .build()
//        );
//    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // Cẩn thận với "*" trong production. Thay bằng các origin cụ thể.
        // Ví dụ: List.of("http://localhost:3000", "https://yourfrontend.com")
        configuration.setAllowedOriginPatterns(List.of("*"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("*")); // Cho phép tất cả headers
        configuration.setAllowCredentials(true); // Quan trọng nếu bạn dùng cookie/headers xác thực
        configuration.setMaxAge(3600L); // Thời gian preflight request có thể được cache

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration); // Áp dụng cho tất cả các path
        return source;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}

