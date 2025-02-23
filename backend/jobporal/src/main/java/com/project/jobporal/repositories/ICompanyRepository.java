package com.project.jobporal.repositories;

import com.project.jobporal.models.Companies;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ICompanyRepository extends JpaRepository<Companies, Long> {

}
