import { registerRecruiter } from "./auth.js";

document
  .getElementById("registerForm")
  .addEventListener("submit", async (e) => {
    e.preventDefault();

    const name = document.getElementById("fullName").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const retypePassword = document.getElementById("retypePassword").value;
    if (password != retypePassword) {
      Swal.fire({
        title: "Password mismatch",
        text: "Password and Retype Password do not match.",
        icon: "error",
      });
      return;
    }
    try {
      await registerRecruiter(name, email, password);
      //   localStorage.setItem("user", JSON.stringify(user));

      Swal.fire({
        title: "Register successfully",
        text: "Please login for use service",
        icon: "success",
      }).then(() => {
        window.location.href = "./login2.html";
      });
    } catch (err) {
      Swal.fire({
        title: "Registration error",
        text: `${err.message}`,
        icon: "error",
      });
    }
  });
