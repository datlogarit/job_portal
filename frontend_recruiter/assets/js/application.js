const user = JSON.parse(localStorage.getItem("user"));
let imageSrc = user.companyId.url_avt.startsWith("http")
  ? user.companyId.url_avt
  : `http://localhost:8088/api/v1/company/images/${user.companyId.url_avt}`;
avt_com.setAttribute("src", `${imageSrc}`);
const jobName = document.getElementById("jobName");
const urlParams = new URLSearchParams(window.location.search);
const jobId = urlParams.get("jobId");
const jobTitle = urlParams.get("jobTitle");
const notyf = new Notyf({
  duration: 2500,
  position: { x: "right", y: "top" },
  dismissible: true,
});
// ================= Utility Functions =================
function formatDate(dateString) {
  return new Date(dateString).toLocaleDateString("en-US", {
    year: "numeric",
    month: "short",
    day: "2-digit",
  });
}

document.addEventListener("DOMContentLoaded", fetApplication(jobId));
async function fetApplication(jobId) {
  const result = await fetch(
    `http://localhost:8088/api/v1/application/job/${jobId}`
  );
  let applications = await result.json();
  jobName.innerHTML = jobTitle;
  applications.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
  renderApplicationTable(applications);
}
function renderApplicationTable(applications) {
  const applicationBody = document.getElementById("tableBody");
  applicationBody.innerHTML = "";
  if (!applications.length) {
    const tableContent = document.getElementById("tableContent");
    const div = document.createElement("div");
    div.classList.add("w-full", "text-center", "mt-4", "!text-[20px]");
    div.innerHTML = "No applicant";
    tableContent.append(div);
  } else {
    applications.forEach((application) => {
      const row = document.createElement("tr");
      row.innerHTML = `
      <td class="p-2.5">${application.applicantId.userId.name}</td>
      <td class="p-2.5">${application.applicantId.userId.email}</td>
      <td class="p-2.5">${application.applicantId.userId.phoneNumber}</td>
      <td class="p-2.5">${application.message}</td>
      <td class="p-2.5">${formatDate(application.createdAt)}</td>
      <td class="p-2.5 text-green-600 hover:underline cursor-pointer" onclick="getResume('${
        application.cvUrl
      }')">Resume</td>
      <td class="p-2.5 min-w-[120px]">
      ${
        application.statusApply == "Pending"
          ? '<div class="w-2.5 h-2.5 inline-block rounded-full mr-0.5 bg-[#faad14]"></div>'
          : application.statusApply === "Approved"
          ? '<div class="w-2.5 h-2.5 inline-block rounded-full mr-0.5 bg-[#4eba19]"></div>'
          : '<div class="w-2.5 h-2.5 inline-block rounded-full mr-0.5 bg-[#ff4d4f]"></div>'
      }
      ${application.statusApply}
      </td>
      ${
        application.statusApply == "Pending"
          ? `
      <td class="p-2.5 space-x-2 !w-[120px]" style="min-width: 120px;">
      <button style="border-radius: 8px;" onclick="changeStatusApplication(${application.id},'Approved')"
          class="bg-[#8beac6] text-[#1A1A1A] px-2 py-1  hover:bg-green-400"><ion-icon
              name="checkmark-outline"></ion-icon></button>
      <button onclick="changeStatusApplication(${application.id},'Rejected')" style="border-radius: 8px;margin-right: 5px;"
          class="bg-[rgba(255,0,0,0.55)] text-[#1A1A1A] px-2 py-1  hover:bg-[rgba(255,0,0,0.85)]"><ion-icon
              name="close-outline"></ion-icon></button>
      </td>
      `
          : ""
      }
       `;
      applicationBody.appendChild(row);
    });
  }
}
// ==================search and filter application================
inputSearch.addEventListener("keyup", function () {
  const keyword = this.value.toLowerCase();
  const applications = document.querySelectorAll("tbody tr");

  applications.forEach(function (application) {
    const text = application.textContent.toLowerCase();
    if (text.includes(keyword)) {
      application.style.display = "";
    } else {
      application.style.display = "none";
    }
  });
});

function filterJob() {
  let selectedValue = document.getElementById("selecedFilter").value;
  const rows = document.querySelectorAll("tbody tr");
  rows.forEach((row) => {
    const statusCell = row.cells[6]; // ô thứ 4 (đếm từ 0)
    if (selectedValue == "All") {
      row.style.display = "";
    } else if (selectedValue == statusCell.innerText.trim()) {
      row.style.display = "";
    } else {
      row.style.display = "none";
    }
  });
}
function changeStatusApplication(applicationId, status) {
  fetch(`http://localhost:8088/api/v1/application/${applicationId}`, {
    method: "PUT",
    headers: { "Content-type": "application/json" },
    body: JSON.stringify({
      status_apply: status,
    }),
  }).then((result) => {
    if (result.ok) {
      Swal.fire({
        title: "Success!",
        text: `${status} success!.`,
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
      });
      setTimeout(() => {
        window.location.href = `../../application.html?jobId=${jobId}&jobTitle=${jobTitle}`;
      }, 1500);
    } else {
      notyf.error("An error occurred, please try again!");
    }
  });
}
// function getResume(cvUrl) {
//   fetch(`http://localhost:8088/api/v1/application/resume/${cvUrl}`)
//     .then((result) => {
//       if (result.ok) {
//         return res.blob();
//       }
//     })
//     .then((blob) => {
//       const fileURL = URL.createObjectURL(blob);
//       window.open(fileURL, "_blank"); // mở file trong tab mới
//     });
// }

function getResume(cvUrl) {
  const spinner = document.getElementById("loadingSpinner");
  spinner.classList.remove("d-none"); // Hiện loading
  fetch(`http://localhost:8088/api/v1/application/resume/${cvUrl}`)
    .then((res) => {
      if (!res.ok) throw new Error("Can't open file");
      return res.blob();
    })
    .then((blob) => {
      const fileUrl = URL.createObjectURL(blob);
      // Mở file PDF trong tab mới
      window.open(fileUrl, "_blank");
    })
    .catch((err) => {
      alert("Error whilte open file: " + err.message);
    })
    .finally(() => {
      spinner.classList.add("d-none"); // Ẩn loading
    });
}

var logout_button = document.getElementById("logout_button");
logout_button.addEventListener("click", () => {
  location.href = "../../../login2.html";
  localStorage.removeItem("user");
  console.log("success");
});
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
