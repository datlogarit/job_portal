// js/login.js
import { loginRecruiter } from "./auth.js";

const userOld = JSON.parse(localStorage.getItem("user"));

if (userOld) {
  await loginRecruiter(userOld.userId.email, userOld.userId.password);
  const user = JSON.parse(localStorage.getItem("user"));

  if (!user.companyId || !user.verifyId || user.verifyId?.status != 3) {
    // Nếu chưa có công ty hoặc chưa xác thực
    document.getElementById("modal").classList.remove("hidden");
    document.getElementById("form_login").classList.add("hidden");
    document.getElementById(
      "name_text"
    ).innerHTML = `Xin chào, ${user.userId.name}`;
    if (user.companyId) {
      document.getElementById(
        "step_company"
      ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
                        </span>`;
    }
    if (user.verifyId) {
      if (user.verifyId.status == 1) {
        document.getElementById(
          "step_verify"
        ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
                        </span>`;
        document.getElementById(
          "step_admin_review"
        ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fa-solid fa-clock text-[#2563eb] text-2xl"></i>
                        </span>`;
      }
      if (user.verifyId.status == 2) {
        document.getElementById(
          "step_verify"
        ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
                        </span>`;
        document.getElementById(
          "step_admin_review"
        ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fa-solid fa-circle-xmark text-red-500 text-2xl"></i>
                        </span>`;
        document.getElementById(
          "step_admin_review_text"
        ).outerHTML = `<span class="text-red-500 mr-1">Xét duyệt thất bại, bạn cần gửi lại thông tin xác minh</span>
`;
      }
    }
  } else {
    // Nếu đã đăng nhập → chuyển tới trang chính
    window.location.href = "/index.html";
  }
}
// Nếu chưa đăng nhập → ở lại trang login
document.getElementById("login_button").addEventListener("click", async (e) => {
  e.preventDefault();
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  try {
    await loginRecruiter(email, password);
    const user = JSON.parse(localStorage.getItem("user"));

    Swal.fire({
      title: "Success",
      text: "Login successfully",
      icon: "success",
      showConfirmButton: false,
      timer: 1500,
    });

    if (
      !user.companyId ||
      !user.verifyId ||
      (user.verifyId && user.verifyId?.status != 3)
    ) {
      // Nếu chưa có công ty hoặc chưa xác thực
      document.getElementById("modal").classList.remove("hidden");
      document.getElementById("form_login").classList.add("hidden");
      document.getElementById(
        "name_text"
      ).innerHTML = `Hello, ${user.userId.name}`;
      if (user.companyId) {
        document.getElementById(
          "step_company"
        ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
                        </span>`;
      }
      if (user.verifyId) {
        if (user.verifyId.status == 1) {
          document.getElementById(
            "step_verify"
          ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
                        </span>`;
        }
        if (user.verifyId.status == 2) {
          document.getElementById(
            "step_verify"
          ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
                        </span>`;
          document.getElementById(
            "step_admin_review"
          ).outerHTML = `<span class="w-6 h-6 flex items-center justify-center mr-3">
                            <i class="fa-solid fa-circle-xmark text-red-500 text-2xl"></i>
                        </span>`;
          document.getElementById(
            "step_admin_review_text"
          ).outerHTML = `<span class="text-red-500 mr-1">Authentication failed, please resend information</span>`;
        }
      }
    } else {
      setTimeout(() => {
        window.location.href = "./index.html";
      }, 1500);
    }
  } catch (err) {
    // document.getElementById("error").textContent = err.message;
    Swal.fire({
      title: "Error",
      text: `${err.message}`,
      icon: "error",
    });
    document.getElementById("email").value = "";
    document.getElementById("password").value = "";
  }
});
