package com.project.jobportal.utilities;

import com.project.jobportal.DTOs.JobDTO;
import com.project.jobportal.services.JobService;
import lombok.RequiredArgsConstructor;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;

import javax.swing.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
public class ScraperJobs {
    //    @Autowired
    private final JobService jobService;

    public static void main(String[] args) {
        String baseUrl = "https://www.careerlink.vn/tim-viec-lam-tai/ha-noi/HN?gad_source=1&page=";
        int maxPages = 5; // cào 5 page 1 lần
        List<String> allJobUrls = new ArrayList<>();
        try {
            for (int page = 1; page <= maxPages; page++) {
                String url = baseUrl + page;
                System.out.println("Đang cào trang: " + url);

                Document doc = Jsoup.connect(url)
                        .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
                        .header("Accept-Language", "en-US,en;q=0.9")
                        .header("Referer", "https://www.google.com/")
                        .timeout(10 * 1000)
                        .get();

                // Lấy danh sách công việc trên trang hiện tại
                Elements jobLinks = doc.select(".job-link");

                if (jobLinks.isEmpty()) {
                    System.out.println("Không tìm thấy công việc trên trang " + page + ", dừng cào.");
                    break; // Nếu không có dữ liệu, dừng lại
                }

                for (Element job : jobLinks) {
                    String jobUrl = job.absUrl("href");
                    allJobUrls.add(jobUrl);
                }

                Thread.sleep(4000); // Nghỉ 2 giây để tránh bị chặn
                System.out.println("Tìm thấy tổng cộng " + allJobUrls.size() + " công việc.");

                // Duyệt qua từng URL để lấy thông tin chi tiết
                for (String jobDetailUrl : allJobUrls) {
                    scrapeJobDetail(jobDetailUrl);
                }
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void scrapeJobDetail(String jobDetailUrl) {
        try {
            // Kết nối đến trang web
            Document doc = Jsoup.connect(jobDetailUrl)
                    .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36")
                    .header("Accept-Language", "en-US,en;q=0.9")
                    .header("Referer", "https://www.google.com/")
                    .timeout(10 * 100000)
                    .get();

            // Chọn danh sách công việc từ trang
            //  Elements jobElements = doc.select(".job-item");

            String title = doc.select(".job-title").text();  // Tiêu đề công việc
            String location = doc.select(".job-location").text();  // Địa điểm làm việc
            String image = doc.select(".company-img").attr("src");  // Mức lương
            String experience = doc.select(".cli-suitcase-simple").text();
//            String workingTime = doc.select(".job-summary-item .font-weight-bolder").text();
////            String numberRecruitment = doc.select(".job-location").text();//không có - mặc định là 2
//            String gender = doc.select(".job-summary-item font-weight-bolder").text();
//            String position = doc.select(".job-location").text();
//            String exp_date = doc.select(".job-location").text();
            String requirement = doc.select(".job-location").text();
            String description = doc.select(".job-location").text();
            String benefit = doc.select(".job-location").text();
//            String workLocation = doc.select(".job-location").text();
//            String category = doc.select(".job-location").text();
//            String status = doc.select(".job-location").text();
//            String minSalary = doc.select(".job-location").text();
//            String maxSalary = doc.select(".job-location").text();
//            String companyName = doc.select(".job-location").text();
//            String introduction = doc.select(".job-location").text();

            System.out.println("Công việc: " + title);
            System.out.println("kinh nghiem: " + experience);
            System.out.println("Ảnh ọt: " + image);
            System.out.println("Địa điểm: " + location);
//            System.out.println("Mức lương: " + workingTime);
//            System.out.println("Số lượng tuyển: 2");
//            System.out.println("giới tính: " + gender);
//            System.out.println("Vị tri: " + position);
//            System.out.println("exp:" + exp_date);
            System.out.println("yeu cầu: " + requirement);
            System.out.println("Mo ta: " + description);
            System.out.println("Quyen loi: " + benefit);
//            System.out.println("danh mục: " + category);
//            System.out.println("lương tối thểu : " + minSalary);
//            System.out.println("tối da: " + maxSalary);


//            System.out.println("------------------------");
//            jobService.createVirtualData(title, experience, workingTime, "2", gender, position,
//                    exp_date, requirement, description, benefit, workLocation, category, status, minSalary,
//                    maxSalary, companyName, image, introduction, location);
            // Sau này có thể lưu vào database
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
