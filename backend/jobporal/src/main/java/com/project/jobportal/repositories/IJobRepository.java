package com.project.jobportal.repositories;

import com.project.jobportal.models.Categories;
import com.project.jobportal.models.Jobs;

import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

//tìm kiếm theo title
public interface IJobRepository extends JpaRepository<Jobs, Long> {

    @Override
    Page<Jobs> findAll(Pageable pageable);// ghi đè phương thức để lấy job theo trang

    // truy vấn theo từ khóa tìm kiếm
    @Query("SELECT j FROM Jobs j WHERE LOWER(j.title) LIKE LOWER(CONCAT('%', :title, '%'))")
    Page<Jobs> searchJob(@Param("title") String title, Pageable pageable);

    /*
     * truy vấn theo category
     * phương thức bên dưới đã được JPA hỗ trợ, nhưng phải
     * chú ý truyền đúng tham số cho categoryId (có type là categories)
     */
    Page<Jobs> findByCategoryId(Categories categoryId, Pageable pageable);

    /*
     * truy vấn theo companyid
     * từ job truy vấn đến recruiter (postedBy), từ recruiter truy vấn đến company,
     * từ company truy vấn đến id
     */
    @Query("SELECT j FROM Jobs j WHERE j.postedBy.companyId.id = :companyId")
    Page<Jobs> findJobsByCompanyId(@Param("companyId") long companyId, Pageable pageable);

    /* lọc job theo khu vực, kinh nghiệm, mức lương, ngành nghề */
    @Query("SELECT j FROM Jobs j WHERE " +
            "(:category IS NULL OR j.categoryId.name LIKE %:category%) AND " +
            "(:position IS NULL OR j.position = :position) AND " +
            "(:experience IS NULL OR j.experience = :experience) AND " +
            "(:minSalary IS NULL OR j.minSalary >= :minSalary) AND " +
            "(:maxSalary IS NULL OR j.maxSalary <= :maxSalary)")
    Page<Jobs> filterJobs(@Param("category") String category,
                          @Param("position") String position,
                          @Param("experience") String experience,
                          @Param("minSalary") Integer minSalary,
                          @Param("maxSalary") Integer maxSalary,
                          Pageable pageable);

}