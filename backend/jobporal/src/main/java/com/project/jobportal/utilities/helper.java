package com.project.jobportal.utilities;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

public class helper {
    static public File convertWordToPdf(File wordFile) throws IOException {
        File outputDir = wordFile.getParentFile();

        // Đường dẫn đầy đủ tới LibreOffice
        String libreOfficePath = "C:\\Program Files\\LibreOffice\\program\\soffice.exe";

        ProcessBuilder pb = new ProcessBuilder(
                libreOfficePath,
                "--headless",
                "--convert-to", "pdf",
                "--outdir", outputDir.getAbsolutePath(),
                wordFile.getAbsolutePath()
        );
        pb.redirectErrorStream(true);
        Process process = pb.start();
        try {
            process.waitFor();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        // Thay thế đuôi .docx hoặc .doc bằng .pdf
        String fileName = wordFile.getName();
        String pdfFileName = fileName.replaceAll("(?i)\\.docx?$", ".pdf");

        File pdfFile = new File(outputDir, pdfFileName);
        if (!pdfFile.exists()) {
            throw new FileNotFoundException("Không tìm thấy file PDF sau khi chuyển đổi: " + pdfFileName);
        }
        return pdfFile;
    }
}
