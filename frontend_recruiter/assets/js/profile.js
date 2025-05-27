const user = JSON.parse(localStorage.getItem("user"));
let imageSrc = user.companyId.url_avt.startsWith("http")
  ? user.companyId.url_avt
  : `http://localhost:8088/api/v1/company/images/${user.companyId.url_avt}`;
avt_com.setAttribute("src", `${imageSrc}`);
document.addEventListener("DOMContentLoaded", () => {
  fetUserInf();
});
function fetUserInf() {
  fetch(`http://localhost:8088/api/v1/user/${user.userId.id}`)
    .then((result) => {
      if (result.ok) {
        return result.json();
      }
    })
    .then((user) => {
      document.getElementById("fullName").value = user.name;
      document.getElementById("phoneNumber").value = user.phoneNumber;
      document.getElementById("birthDay").value = user.dob;
    });
}
function updateInfo() {
  const fullName = document.getElementById("fullName").value;
  const phoneNumber = document.getElementById("phoneNumber").value;
  const birthDay = document.getElementById("birthDay").value;
  fetch(`http://localhost:8088/api/v1/user/${user.userId.id}`, {
    method: "PUT",
    headers: { "Content-type": "application/json" },
    body: JSON.stringify({
      name: fullName,
      phone_number: phoneNumber,
      dob: birthDay,
    }),
  }).then((result) => {
    if (result.ok) {
      Swal.fire({
        title: "Success!",
        text: `Update personal information success!.`,
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
      });
      setTimeout(() => {
        window.location.href = "../../profile.html";
      }, 1500);
    } else {
      Swal.fire({
        title: "Error!",
        text: `This phone number is exist.Try again!`,
        icon: "error",
        showConfirmButton: true,
      });
    }
  });
}
function changePassword() {
  let oldPassword = document.getElementById("oldPassword").value;
  let newPassword = document.getElementById("newPassword").value;
  let retypePassword = document.getElementById("retypePassword").value;
  if (newPassword != retypePassword) {
    Swal.fire({
      title: "Error!",
      text: `Incorrect password confirmation!.`,
      icon: "error",
      showConfirmButton: true,
    });
  } else {
    fetch(
      `http://localhost:8088/api/v1/user/password/${user.userId.id}?oldPassword=${oldPassword}&newPassword=${newPassword}`,
      {
        method: "PUT",
      }
    )
      .then((response) => {
        return response.json();
      })
      .then((response) => {
        if (response.status == 200) {
          Swal.fire({
            title: "Success!",
            text: `Change password success!.`,
            icon: "success",
            showConfirmButton: false,
            timer: 1500,
          });
          document.getElementById("oldPassword").value = "";
          document.getElementById("newPassword").value = "";
          document.getElementById("retypePassword").value = "";
        } else {
          Swal.fire({
            title: "Error!",
            text: `${response.message}`,
            icon: "error",
            showConfirmButton: true,
          });
        }
      });
  }
}
function fetchNotify() {
  fetch(`http://localhost:8088/api/v1/notiuser/${user.userId.id}`)
    .then((result) => {
      return result.json();
    })
    .then((notys) => {
      renderNotify(notys);
    });
}
function renderNotify(notys) {
  const offcan_body_job = document.getElementById("offcan_body_job");
  offcan_body_job.innerHTML = "";
  notys.forEach((noty) => {
    const body_noty = document.createElement("div");
    body_noty.innerHTML = `
      ${
        noty.isRead
          ? `<div class="bg-gray-100 mt-1 p-3 rounded-md shadow-sm">
            <h4 class="text-primary font-semibold mb-1">${
              noty.idNoti.title
            }</h4>
            <p class="text-gray-800 mb-2">${noty.idNoti.content}
            </p>
            <p class="text-sm text-gray-500">${formatDateTime(
              noty.idNoti.createdAt
            )}</p>
          </div>`
          : `<div onclick="readNotify(this, ${
              noty.id.idNoti
            })" class="bg-blue-100 mt-1 p-3 rounded-md shadow-sm">
            <h4 class="text-primary font-semibold mb-1">${
              noty.idNoti.title
            }</h4>
            <p class="text-gray-800 mb-2">${noty.idNoti.content}
            </p>
            <p class="text-sm text-gray-500">${formatDateTime(
              noty.idNoti.createdAt
            )}</p>
          </div>`
      }
    `;
    offcan_body_job.appendChild(body_noty);
  });
}
function readNotify(element, notiId) {
  fetch(`http://localhost:8088/api/v1/notiuser`, {
    method: "PUT",
    headers: { "Content-type": "application/json" },
    body: JSON.stringify({
      id_noti: notiId,
      id_user: user.userId.id,
      is_read: 1,
    }),
  }).then((result) => {
    if (result.ok) {
      element.classList.remove("bg-blue-100");
      element.classList.add("bg-gray-100");
    }
  });
}
function formatDateTime(isoDateTimeStr) {
  const date = new Date(isoDateTimeStr);

  const day = String(date.getDate()).padStart(2, "0");
  const month = String(date.getMonth() + 1).padStart(2, "0"); // tháng bắt đầu từ 0
  const year = date.getFullYear();

  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");

  return `${day}/${month}/${year} ${hours}:${minutes}`;
}
console.log(formatDateTime("2025-03-30T23:57:59"));
var logout_button = document.getElementById("logout_button");
logout_button.addEventListener("click", () => {
  location.href = "../../../login2.html";
  localStorage.removeItem("user");
  console.log("success");
});
