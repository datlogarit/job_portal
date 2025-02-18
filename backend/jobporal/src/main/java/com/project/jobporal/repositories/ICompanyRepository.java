package com.project.jobporal.repositories;

import com.project.jobporal.models.Companies;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ICompanyRepository extends JpaRepository<Companies, Long> {

}

