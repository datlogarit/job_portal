package com.project.jobportal.utilities;

import com.project.jobportal.JobporalApplication;
import com.project.jobportal.services.JobService;
import io.github.bonigarcia.wdm.WebDriverManager;
import lombok.RequiredArgsConstructor;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

@Component
@RequiredArgsConstructor
public class SeleniumScraper {
    private final JobService jobService;

    private static final List<String> proxyList = Arrays.asList(
            "113.160.208.24:19132",
            "14.177.235.17:8080",
            "117.7.239.122:8080"
    );


    //su dung proxy de doi IP
//    public static WebDriver createDriverWithProxy() {
//        Random rand = new Random();
//        String proxy = proxyList.get(rand.nextInt(proxyList.size())); // Chọn ngẫu nhiên một proxy
//
//        ChromeOptions options = new ChromeOptions();
//        options.addArguments("--proxy-server=" + proxy);
//        return new ChromeDriver(options);
//    }

    private WebDriver setupDriver() {
        ChromeOptions options = new ChromeOptions();

        // Thay đổi User-Agent để trông giống trình duyệt thật
        options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");

        // Ẩn dấu hiệu Selenium
        options.addArguments("--disable-blink-features=AutomationControlled");

        // Nếu bạn muốn dùng proxy
        // options.addArguments("--proxy-server=http://your-proxy:port");

        WebDriverManager.chromedriver().setup();
        WebDriver driver = new ChromeDriver(options);

        // Xóa dấu vết Selenium (chạy ngay sau khi tạo WebDriver)
        ((JavascriptExecutor) driver).executeScript("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})");

        return driver;
    }

    public void scrape() {


        WebDriverManager.chromedriver().setup();
        WebDriver driver = setupDriver();
        try {//xong trang 1-50
            //xong phần job về IT
//             xong trang 150 - 194
//            xong job 38 cua trang 137
            for (int i = 100; i <= 149; i++) { // Crawl 1 trang


                driver.get(String.format("https://www.vietnamworks.com/viec-lam?page=%d", i));

                WebDriverWait wait = new WebDriverWait(driver, java.time.Duration.ofSeconds(20));
                wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".view_job_item.search_list")));
                JavascriptExecutor js = (JavascriptExecutor) driver;
                int scrolls = 2; // Số lần cuộn xuống (điều chỉnh theo trang web)
                for (int s = 0; s < scrolls; s++) {
                    js.executeScript("window.scrollTo(0, document.body.scrollHeight);");
                    Thread.sleep(1000); // Chờ 2 giây cho dữ liệu mới tải xong
                }


                List<WebElement> jobList = driver.findElements(By.cssSelector(".sc-beeQDc.hGhtuQ a"));

                List<String> jobUrls = new ArrayList<>();
                for (WebElement job : jobList) {
                    jobUrls.add(job.getAttribute("href"));
                }
                int count = 1;
                for (String jobUrl : jobUrls) {

                    driver.get(jobUrl); // Mở trang chi tiết của job
//                    WebDriverWait wait = new WebDriverWait(driver, java.time.Duration.ofSeconds(10));
                    wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".sc-ab270149-0.hAejeW")));
                    String jobTitle = driver.findElement(By.cssSelector(".sc-ab270149-0.hAejeW")).getText();
                    String workLocation = driver.findElement(By.cssSelector(".sc-2557ebc-1.ebdjLi")).getText();
                    String category = driver.findElements(By.cssSelector(".sc-7bf5461f-3.bPjxRh")).get(0).getText().toLowerCase();
                    String companyName = driver.findElement(By.cssSelector(".egZKeY")).getText().toLowerCase();
                    String ImgCpnUrl = driver.findElements(By.cssSelector("img")).get(7).getAttribute("src");
                    List<WebElement> deAndRe = driver.findElements(By.cssSelector(".sc-1671001a-6.dVvinc"));
                    String description = deAndRe.get(0).getText();
                    String requirement = (String) js.executeScript("return arguments[0].textContent;", deAndRe.get(1));
                    int minSalary = generateMinSalary();
                    int maxSalary = generateMaxSalary(minSalary);
                    jobService.createVirtualData(jobTitle, valueRange(1, 10) + " năm kinh nghiệm",
                            getRandomString(JOB_TYPES), valueRange(1, 10), getRandomString(SEX),
                            getRandomString(POSITION_JOBS), exp_date, requirement, description, benefit,
                            workLocation, category, minSalary, maxSalary, companyName, ImgCpnUrl,
                            introduction, workLocation, getRandomEmail(), getRandomString(NAMES), password);
                    System.out.println("xong job " + count + " cua trang " + i);
                    count++;
                    Thread.sleep(ThreadLocalRandom.current().nextInt(800, 1100));
                }
                Thread.sleep(7000);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }
    }

    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(JobporalApplication.class, args);
        SeleniumScraper scraper = context.getBean(SeleniumScraper.class);
        scraper.scrape();
    }

    public static String getRandomString(String[] type) {
        int index = ThreadLocalRandom.current().nextInt(type.length);
        return type[index];
    }

    private static int valueRange(int min, int max) {
        return ThreadLocalRandom.current().nextInt(min, max + 1);
    }

    public static String getRandomEmail() {
        Random random = new Random();
        String name = NAMES[random.nextInt(NAMES.length)]; // Chọn ngẫu nhiên từ 30 tên
        int number = random.nextInt(100000); // Thêm số ngẫu nhiên từ 0 - 9999
        String domain = DOMAINS[random.nextInt(DOMAINS.length)]; // Chọn domain ngẫu nhiên
        return name + number + "@" + domain;
    }

    private static final String[] JOB_TYPES = {"part time", "fulltime", "remote", "thỏa thuận"};
    private static final String[] SEX = {"Nam", "Nữ", "Không yêu cầu"};
    private static final String[] NAMES = {"john", "jane", "david", "alice", "michael", "sophia", "jack", "piter", "bin"};
    private static final String[] POSITION_JOBS = {"intern", "senior", "junior", "fresher", "leader", "manager"};
    private static final String[] DOMAINS = {
            "gmail.com", "yahoo.com", "outlook.com", "example.com", "hotmail.com", "icloud.com"
    };

    private static final String password = "12345678";
    private static final String introduction = "đây là công ty để tạo dữ liệu cho hệ thống";
    private static final String benefit = "đãi ngộ tốt";
//    private static int minSalary = generateMinSalary();
//    private static int maxSalary = generateMaxSalary(minSalary);

    private static int generateMinSalary() {
        int min = ThreadLocalRandom.current().nextInt(5000000, 50000000 + 1);
        return (min / 1000000) * 1000000; // Làm tròn thành bội số của 1 triệu
    }

    private static int generateMaxSalary(int minSalary) {
        int max = minSalary + ThreadLocalRandom.current().nextInt(2000000, 10000000 + 1);
        return (max / 1000000) * 1000000; // Làm tròn thành bội số của 1 triệu
    }

    private static LocalDate exp_date = LocalDate.of(2025, 8, 8);

//    static {
//        try {
//            exp_date = new SimpleDateFormat("dd/MM/yyyy").parse("08/08/2025");
//        } catch (ParseException e) {
//            throw new RuntimeException(e);
//        }
//    }
}

