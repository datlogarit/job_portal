var avt_com = document.getElementById("avt_com");

const user = JSON.parse(localStorage.getItem("user"));
console.log(user);
let imageSrc = user.companyId.url_avt.startsWith("http")
  ? user.companyId.url_avt
  : `http://localhost:8088/api/v1/company/images/${user.companyId.url_avt}`;
avt_com.setAttribute("src", `${imageSrc}`);

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
document.addEventListener("DOMContentLoaded", async () => {
  await checkUnreadNoti();
});
const notificationItem = document.getElementById("notification_item");
async function checkUnreadNoti() {
  try {
    const response = await fetch(
      `http://localhost:8088/api/v1/notiuser/totalUnread/${user.userId.id}`
    );
    const data = await response.text(); // Hoặc response.json() nếu API trả JSON

    const totalUnread = parseInt(data, 10); // Đảm bảo data là số

    const notificationItem = document.getElementById("notification_item");

    if (totalUnread > 0) {
      if (!notificationItem.querySelector(".red-dot")) {
        let redDot = document.createElement("div");
        redDot.classList.add(
          "absolute",
          "w-2.5",
          "h-2.5",
          "bg-red-600",
          "rounded-[50%]",
          "top-2.5",
          "right-3.5",
          "red-dot"
        );
        notificationItem.appendChild(redDot);
      }
    }

    return totalUnread; // ✅ Giá trị trả về chính xác
  } catch (error) {
    console.error("Error fetching notifications:", error);
    return 0; // hoặc null tùy ý, nhưng nên có để tránh undefined
  }
}

function renderNotify(notys) {
  const offcan_body_job = document.getElementById("offcan_body_job");
  offcan_body_job.innerHTML = "<div></div>";
  if (notys.length == 0) {
    const offcan_body = document.getElementById("offcan_body");
    offcan_body.innerHTML = ` <div class="flex flex-col items-center">
                        <img src="./assets/images/Mailbox-bro.svg" alt="">
                        <h4 class="text-[20px] font-bold">No notifications</h4>
                    </div>`;
  } else {
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
             ${
               noty.idNoti.jobRelated && noty.idNoti.jobRelated.isLock == 0
                 ? `<div class="flex flex-row justify-between items-center">
                        <p class="text-sm text-gray-500">${formatDateTime(
                          noty.idNoti.createdAt
                        )}</p>
                        <button class="bg-blue-600 rounded-md text-white px-2 py-1" onclick="viewDetailJob(${
                          noty.idNoti.jobRelated.id
                        }, '${noty.idNoti.jobRelated.title}')">View</button>
                    </div>`
                 : `<div class="flex flex-row justify-between items-center">
                        <p class="text-sm text-gray-500">${formatDateTime(
                          noty.idNoti.createdAt
                        )}</p>
                        <div></div>
                    </div>`
             }
          </div>`
          : `<div onclick="readNotify(this, ${
              noty.id.idNoti
            })" class="bg-blue-100 mt-1 p-3 rounded-md shadow-sm">
            <h4 class="text-primary font-semibold mb-1">${
              noty.idNoti.title
            }</h4>
            <p class="text-gray-800 mb-2">${noty.idNoti.content}
            </p>
           ${
             noty.idNoti.jobRelated && noty.idNoti.jobRelated.isLock == 0
               ? `<div class="flex flex-row justify-between items-center">
                        <p class="text-sm text-gray-500">${formatDateTime(
                          noty.idNoti.createdAt
                        )}</p>
                        <button class="bg-blue-600 rounded-md text-white px-2 py-1" onclick="viewDetailJob(${
                          noty.idNoti.jobRelated.id
                        }, '${noty.idNoti.jobRelated.title}')">View</button>
                    </div>`
               : `<div class="flex flex-row justify-between items-center">
                        <p class="text-sm text-gray-500">${formatDateTime(
                          noty.idNoti.createdAt
                        )}</p>
                        <div></div>
                    </div>`
           }
          </div>`
      }
    `;
      offcan_body_job.appendChild(body_noty);
    });
  }
}
async function readNotify(element, notiId) {
  let totalUnRead = await checkUnreadNoti();
  totalUnRead = totalUnRead - 1;
  if (!totalUnRead) {
    notificationItem.querySelector(".red-dot").classList.add("hidden");
  }
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
function viewDetailJob(jobId, title) {
  //chuyển đến trang detail kèm theo id với title
  window.location.href = `../../application.html?jobId=${jobId}&jobTitle=${title}`;
}
