package com.project.jobportal.repositories;

import com.project.jobportal.models.Companies;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ICompanyRepository extends JpaRepository<Companies, Long> {
    Optional<Companies> findByName(String name);
}
