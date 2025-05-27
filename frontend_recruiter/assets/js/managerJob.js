const avt_com = document.getElementById("avt_com");
const tableBody = document.getElementById("jobTableBody");
const inputSearch = document.getElementById("inputSearch");
const notyf = new Notyf({
  duration: 2500,
  position: { x: "right", y: "top" },
  dismissible: true,
});

const user = JSON.parse(localStorage.getItem("user"));
if (user?.companyId?.url_avt) {
  let imageSrc = user.companyId.url_avt.startsWith("http")
    ? user.companyId.url_avt
    : `http://localhost:8088/api/v1/company/images/${user.companyId.url_avt}`;
  avt_com.setAttribute("src", `${imageSrc}`);
}

document.addEventListener("DOMContentLoaded", () => fetchJobWithPage(1));
inputSearch.addEventListener("keyup", function () {
  const keyword = this.value.toLowerCase();
  const jobs = document.querySelectorAll("tbody tr");

  jobs.forEach(function (job) {
    const text = job.textContent.toLowerCase();
    if (text.includes(keyword)) {
      job.style.display = "";
    } else {
      job.style.display = "none";
    }
  });
});

function filterJob() {
  let selectedValue = document.getElementById("selecedFilter").value;
  const rows = document.querySelectorAll("tbody tr");
  rows.forEach((row) => {
    const statusCell = row.cells[3]; // ô thứ 4 (đếm từ 0)
    if (selectedValue == "All") {
      row.style.display = "";
    } else if (selectedValue == statusCell.innerText.trim()) {
      row.style.display = "";
    } else {
      row.style.display = "none";
    }
  });
}
// ================= Utility Functions =================
function formatDate(dateString) {
  return new Date(dateString).toLocaleDateString("en-US", {
    year: "numeric",
    month: "short",
    day: "2-digit",
  });
}

function cutContent(content, maxLength) {
  return content.length <= maxLength
    ? content
    : content.slice(0, maxLength) + " ....";
}

function formatText(text) {
  return text ? text.charAt(0).toUpperCase() + text.slice(1) : "";
}

// ================= Job Fetch & Render =================
function fetchJobWithPage(page) {
  fetch(
    `http://localhost:8088/api/v1/job/recruiter/${user.userId.id}?page=${
      page - 1
    }&limit=10`
  )
    .then((response) => response.json())
    .then((result) => {
      const jobs = result["job"] || [];
      const totalPage = result["total Page"];

      tableBody.innerHTML = "";
      if (!jobs.length) {
        const contentCenter = document.getElementById("contentCenter");
        const noty = document.createElement("div");
        noty.innerHTML = `<div class="text-[22px] font-normal w-full text-center mt-3">There are currently no posts.</div>`;
        // contentCenter.innerHTML = ;
        contentCenter.appendChild(noty);
      } else {
        renderJobTable(jobs);
        renderPagination(page, totalPage);
      }
    })
    .catch((error) => {
      console.error("Fetch error:", error);
      notyf.error("Lỗi khi tải danh sách công việc");
    });
}

function renderJobTable(jobs) {
  jobs.forEach((job) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td class="p-3 min-w-[220px] text-green-600 hover:underline cursor-pointer">${cutContent(
        job.title,
        25
      )}</td>
      <td class="p-3">${formatDate(job.createdAt)}</td>
      <td class="p-3">${formatDate(job.expDate)}</td>
      <td class="p-3">
      ${
        job.status === "Opening"
          ? ' <div class="w-2.5 h-2.5 inline-block rounded-full mr-0.5 bg-[#4eba19]"></div>'
          : ' <div class="w-2.5 h-2.5 inline-block rounded-full mr-0.5 bg-[#ff4d4f]"></div>'
      }
      ${formatText(job.status)}
      </td>
      <td class="p-2 text-green-600 hover:underline cursor-pointer" onclick="viewApplicant(${
        job.id
      }, '${job.title}')">Applicant</td>
      ${job.status === "Opening" ? renderActionButtons(job.id) : ""}
    `;
    tableBody.appendChild(row);
  });
}

function renderActionButtons(jobId) {
  return `
    <td class="p-3 space-x-1">
     <!-- <button style="border-radius: 8px;margin-right: 5px;"
        class="bg-[#B3E5FC] text-[#0D47A1] px-2 py-1 hover:bg-blue-300">
        <ion-icon name="create-outline"></ion-icon>
      </button> -->
      <button onclick="inactiveJob(${jobId})" style="border-radius: 8px;"
        class="bg-[rgba(255,0,0,0.55)] text-[#1A1A1A] px-2 py-1 hover:bg-[rgba(255,0,0,0.85)]">
        <ion-icon name="ban-outline"></ion-icon>
      </button>
      <button style="border-radius: 8px;" onclick="showSuggestedApplicants(${jobId})"
        class="bg-[#8beac6] text-[#1A1A1A] px-2 py-1 hover:bg-green-400">
        <ion-icon name="bulb-outline"></ion-icon>
      </button>
    </td>`;
}

// ================= Pagination =================
function renderPagination(currentPage, totalPage) {
  const pagination = document.getElementById("pagination");
  const createPageItem = (page, active = false) =>
    `<li class="page-item ${active ? "active" : ""}">
      <a class="page-link page-number" href="#" data-page="${page}">${page}</a>
    </li>`;

  let pages = [];

  if (totalPage <= 2) {
    for (let i = 1; i <= totalPage; i++) {
      pages.push(createPageItem(i, i === currentPage));
    }
  } else if (currentPage === totalPage) {
    pages.push(createPageItem(currentPage - 2));
    pages.push(createPageItem(currentPage - 1));
    pages.push(createPageItem(currentPage, true));
  } else if (currentPage === 1) {
    pages.push(createPageItem(currentPage, true));
    pages.push(createPageItem(currentPage + 1));
    pages.push(createPageItem(currentPage + 2));
  } else {
    pages.push(createPageItem(currentPage - 1));
    pages.push(createPageItem(currentPage, true));
    pages.push(createPageItem(currentPage + 1));
  }

  pagination.innerHTML = `
    <nav aria-label="Page navigation example">
      <ul class="pagination">
        <li class="page-item">
          <a class="page-link" href="#" id="prevPage" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
        </li>
        ${pages.join("")}
        <li class="page-item">
          <a class="page-link" href="#" id="nextPage" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
        </li>
      </ul>
    </nav>`;

  // ================== Gắn sự kiện click ==================
  document.querySelectorAll(".page-number").forEach((link) => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const page = parseInt(e.target.getAttribute("data-page"));
      fetchJobWithPage(page); // Gọi lại API
    });
  });

  // ================== Xử lý Previous / Next ==================
  document.getElementById("prevPage")?.addEventListener("click", (e) => {
    e.preventDefault();
    if (currentPage > 1) fetchJobWithPage(currentPage - 1);
  });

  document.getElementById("nextPage")?.addEventListener("click", (e) => {
    e.preventDefault();
    if (currentPage < totalPage) fetchJobWithPage(currentPage + 1);
  });
}

// =================== Message alert =============
function inactiveJob(jobId) {
  const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
      confirmButton: "btn btn-danger ms-2",
      cancelButton: "btn btn-primary",
    },
    buttonsStyling: false,
  });
  swalWithBootstrapButtons
    .fire({
      title: "Are you sure?",
      text: "You will not able to active this job!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Confirm!",
      cancelButtonText: "Cancel",
      reverseButtons: true,
    })
    .then((result) => {
      if (result.isConfirmed) {
        try {
          fetch(`http://localhost:8088/api/v1/job/${jobId}`, {
            method: "PUT",
            headers: { "Content-type": "application/json" },
            body: JSON.stringify({
              status: "Closed",
            }),
          }).then((result) => {
            if (result.ok) {
              swalWithBootstrapButtons.fire({
                title: "Success!",
                text: "This job has been actived!.",
                icon: "success",
                showConfirmButton: false,
                timer: 1500,
              });
              setTimeout(() => {
                window.location.href = "../../manager_job.html";
              }, 1500);
            } else {
              swalWithBootstrapButtons.fire({
                title: "Error!",
                text: "An error occurred. Please try again!.",
                icon: "error",
              });
            }
          });
        } catch (error) {
          notyf.error("Error conecting with server. Try again!" + error);
        }
      }
    });
}
async function showSuggestedApplicants(jobId) {
  const container = document.getElementById("applicantCardsContainer");
  container.innerHTML = "";

  const applicants = await fetch(
    `http://localhost:8088/api/v1/applicant/recommendApplicant/${jobId}`
  );

  applicants.json().then((applicants) => {
    applicants.forEach((applicant) => {
      const applicantInfor = applicant["applicant"];
      const statusInvite = applicant["statusInvite"];
      const card = document.createElement("div");
      card.className = "bg-white p-4 rounded shadow";
      card.innerHTML = `
            <div class="max-w-sm mx-auto bg-white rounded-2xl shadow-lg p-6 relative hover:shadow-xl transition-shadow">
                <div class="flex justify-between items-start">
                    <h3 class="text-xl font-semibold text-gray-800">${
                      applicantInfor.userId.name
                    }</h3>
                    ${
                      statusInvite
                        ? "<div></div>"
                        : `<button style="width:40px; height:40px; :hover{
            cursor:point}" class="hover:cursor-pointer btn btn-outline-primary rounded-circle" onclick="inviteApplicant(${jobId},${applicantInfor.id})">
                    <ion-icon name="paper-plane-outline"></ion-icon>
                    </button>`
                    }  
                </div>
                <div class="mt-[10px] space-y-1 text-sm text-gray-700">
                    <p><span class="font-medium mr-0.5">Gender:</span>${
                      applicantInfor.gender
                    }</p>
                    <p><span class="font-medium mr-0.5">Experience:</span> ${
                      applicantInfor.workExperience
                    }</p>
                    <p><span class="font-medium mr-0.5">Position:</span>${
                      applicantInfor.desiredPosition
                    }</p>
                </div>
            </div>
                `;
      container.appendChild(card);
    });
  });

  const modal = new bootstrap.Modal(
    document.getElementById("suggestApplicantModal")
  );
  modal.show();
}

function inviteApplicant(jobId, applicantId) {
  fetch(`http://localhost:8088/api/v1/invite`, {
    method: "POST",
    headers: { "Content-type": "application/json" },
    body: JSON.stringify({
      job_id: jobId,
      applicant_id: applicantId,
    }),
  }).then((result) => {
    if (result.ok) {
      Swal.fire({
        title: "Success!",
        text: "Invite successful candidates!.",
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
      });
      setTimeout(() => {
        const modalElement = document.getElementById("suggestApplicantModal");
        const modal = bootstrap.Modal.getInstance(modalElement);
        if (modal) {
          modal.hide();
        }
      }, 1500);
    } else {
      Swal.fire({
        title: "Error!",
        text: "Invite false candidates!.",
        icon: "error",
        showConfirmButton: false,
        timer: 1500,
      });
    }
  });
}
function viewApplicant(jobId, jobTitle) {
  const encodedTitle = encodeURIComponent(jobTitle);
  window.location.href = `../../application.html?jobId=${jobId}&jobTitle=${encodedTitle}`;
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
