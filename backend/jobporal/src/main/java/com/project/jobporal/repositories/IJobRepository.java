package com.project.jobporal.repositories;

import com.project.jobporal.models.Categories;
import com.project.jobporal.models.Jobs;

import java.util.List;

import org.springframework.boot.autoconfigure.batch.BatchProperties.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

//tìm kiếm theo title
public interface IJobRepository extends JpaRepository<Jobs, Long> {

        @Query("SELECT j FROM Jobs j WHERE LOWER(j.title) LIKE LOWER(CONCAT('%', :title, '%'))")
        List<Jobs> searchJob(@Param("title") String title);

        List<Jobs> findByCategoryId(Categories categoryId);/*
                                                            * trường cateory_id trong bảng jobs là 1 entity
                                                            * nhưng ở đây lại nhận vào 1 Long
                                                            */

        /*
         * từ job truy vấn đến recruiter (postedBy), từ recruiter truy vấn đến company,
         * từ company truy vấn đến id
         */
        @Query("SELECT j FROM Jobs j WHERE j.postedBy.company_id.id = :companyId")
        List<Jobs> findJobsByCompanyId(@Param("companyId") long companyId);

        /* lọc job theo khu vực, kinh nghiệm, mức lương, ngành nghề */
        @Query("SELECT j FROM Jobs j WHERE " +
                        "(:category IS NULL OR j.categoryId.name LIKE %:category%) AND " +
                        "(:position IS NULL OR j.position = :position) AND " +
                        "(:experience IS NULL OR j.experience = :experience) AND " +
                        "(:minSalary IS NULL OR j.minSalary >= :minSalary) AND " +
                        "(:maxSalary IS NULL OR j.maxSalary <= :maxSalary)")
        List<Jobs> filterJobs(@Param("category") String category,
                        @Param("position") String position,
                        @Param("experience") String experience,
                        @Param("minSalary") Integer minSalary,
                        @Param("maxSalary") Integer maxSalary);

}