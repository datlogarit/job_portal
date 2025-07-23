document.getElementById("login_button").addEventListener("click", async () => {
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  await login(email, password);
});

async function login(email, password) {
  try {
    const res = await fetch("http://localhost:8088/api/v1/user/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        email: email,
        password: password,
        role: "ROLE_RECRUITER",
      }),
    });

    if (!res.ok) {
      const errorText = await res.text(); // có thể log để debug
      Swal.fire({
        title: "Error",
        text: errorText,
        icon: "error",
      });
      return;
    }

    const data = await res.json();
    const user = data.user;
    localStorage.setItem("user", JSON.stringify(user));

    // Kiểm tra dữ liệu
    if (!user.companyId || !user.verifyId || user.verifyId?.status !== 3) {
      renderModal(user);
    } else {
      Swal.fire({
        title: "Success",
        text: "Login successfully",
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
      });
      setTimeout(() => {
        window.location.href = "../../index.html";
      }, 1500);
    }
  } catch (error) {
    console.error("Login error:", error);
    Swal.fire({
      title: "Error",
      text: "An unexpected error occurred. Please try again.",
      icon: "error",
    });
  }
}

function renderModal(user) {
  const modal = document.getElementById("modal");
  const form = document.getElementById("form_login");
  const nameText = document.getElementById("name_text");

  modal.classList.remove("hidden");
  form.classList.add("hidden");
  nameText.innerHTML = `Hello, ${user.userId?.name || "user"}`;

  if (user.companyId) {
    document.getElementById("step_company").outerHTML = `
      <span class="w-6 h-6 flex items-center justify-center mr-3">
        <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
      </span>`;
  }

  if (user.verifyId) {
    const status = user.verifyId.status;
    if (status === 1) {
      document.getElementById("step_verify").outerHTML = `
        <span class="w-6 h-6 flex items-center justify-center mr-3">
          <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
        </span>`;
      document.getElementById("step_admin_review").outerHTML = `
        <span class="w-6 h-6 flex items-center justify-center mr-3">
          <i class="fa-solid fa-clock text-[#2563eb] text-2xl"></i>
        </span>`;
    }

    if (status === 2) {
      document.getElementById("step_verify").outerHTML = `
        <span class="w-6 h-6 flex items-center justify-center mr-3">
          <i class="fas fa-check-circle text-[#2563eb] text-2xl"></i>
        </span>`;
      document.getElementById("step_admin_review").outerHTML = `
        <span class="w-6 h-6 flex items-center justify-center mr-3">
          <i class="fa-solid fa-circle-xmark text-red-500 text-2xl"></i>
        </span>`;
      document.getElementById("step_admin_review_text").outerHTML = `
        <span class="text-red-500 mr-1">
          Authentication failed, please resend verification information
        </span>`;
    }
  }
}
