var avt_com = document.getElementById("avt_com");
var notyf = new Notyf({
  duration: 2500,
  position: {
    x: "right", // left | center | right
    y: "top",
  },
  dismissible: true, // Có nút tắt hay không
});

const user = JSON.parse(localStorage.getItem("user"));
if (user) {
  let imageSrc = user.companyId.url_avt.startsWith("http")
    ? user.companyId.url_avt
    : `http://localhost:8088/api/v1/company/images/${user.companyId.url_avt}`;
  avt_com.setAttribute("src", `${imageSrc}`);
}
function postJob() {
  var categoryChoosed = document.getElementById("categoryChoosed").value;
  var workTimeChoosed = document.getElementById("workTimeChoosed").value;
  var titleValue = document.getElementById("titleValue").value;
  var locationValue = document.getElementById("locationValue").value;
  var minSalaryValue = document.getElementById("minSalaryValue").value;
  var maxSalaryValue = document.getElementById("maxSalaryValue").value;
  var genderSelected = document.getElementById("genderSelected").value;
  var positionSelected = document.getElementById("positionSelected").value;
  var experienceValue = document.getElementById("experienceValue").value;
  var quantityValue = document.getElementById("quantityValue").value;
  var datepicker = document.getElementById("datepicker").value;
  var descriptionValue = document.getElementById("descriptionValue").value;
  var requirementValue = document.getElementById("requirementValue").value;
  var benefitValue = document.getElementById("benefitValue").value;
  // alert(user.userId.id);
  fetch("http://localhost:8088/api/v1/job", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      title: titleValue,
      min_salary: minSalaryValue,
      max_salary: maxSalaryValue,
      experience: experienceValue,
      working_time: workTimeChoosed,
      number_recruitment: quantityValue,
      gender: genderSelected,
      position: positionSelected,
      exp_date: datepicker,
      requirement: requirementValue,
      description: descriptionValue,
      benefit: benefitValue,
      work_location: locationValue,
      posted_by: user.userId.id,
      category_id: categoryChoosed,
    }),
  }).then((response) => {
    if (!response.ok) {
      notyf.error("Error while send data!");
      return 0;
    } else {
      Swal.fire({
        title: "Success",
        text: "Post job successfully!",
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
      });
      setTimeout(() => {
        location.href = "../../manager_job.html";
      }, 1500);
    }
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
