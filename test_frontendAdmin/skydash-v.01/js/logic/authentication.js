import { Helper } from "../helper/helper.js";
document.addEventListener("DOMContentLoaded", async () => {
  let response = await fetAllVerification();
  renderTable(response);
});

async function fetAllVerification() {
  try {
    const res = await fetch("http://localhost:8088/api/v1/recruiter/isVerify");
    if (res.ok) {
      const data = await res.json();
      return data;
    } else {
      alert("Lỗi khi fetch: " + res.status);
    }
  } catch (error) {
    alert("Có lỗi khi fetch verification: " + error.message);
  }
}

function renderTable(responses) {
  let bodyTable = document.getElementById("bodyTable");
  bodyTable.innerHTML = "";
  responses.forEach((element) => {
    let row = document.createElement("tr");
    let imageSrc = element.companyId.url_avt.startsWith("http")
      ? element.companyId.url_avt
      : `http://localhost:8088/api/v1/company/images/${element.companyId.url_avt}`;
    row.innerHTML = `
      <td class="py-1">
          <img style="border-radius: unset; width: 40px;height: fit-content;"
              src="${imageSrc}"
              alt="image" />
      </td>
      <td>
          ${Helper.formatText(element.companyId.name, 40)}
      </td>
      <td>
          ${element.companyId.taxCode}
      </td>
      <td>
          ${Helper.formatDateTime(element.verifyId.createdAt)}
      </td>
      <td onclick="getLOA('${
        element.verifyId.authorizationLetterUrl
      }')" class = "hover_box">
          Click here
      </td>
      <td onclick="getBL('${
        element.verifyId.businessLicenseUrl
      }')" class = "hover_box">
          Click here
      </td>

      <td>
          <button type="button" onclick="resolveStatus(${
            element.verifyId.id
          }, 3)" class="btn btn-inverse-success btn-icon">
              <!-- <i class="ti-location-pin"></i> -->
              <ion-icon style="font-size: 18px;"
                  name="checkmark-outline"></ion-icon>
          </button>
          <button onclick="resolveStatus(${
            element.verifyId.id
          }, 2)" type="button" class="btn btn-inverse-danger btn-icon">
              <!-- <i class="ti-email"></i> -->
              <ion-icon style="font-size: 18px;"
                  name="close-outline"></ion-icon>
          </button>
      </td>                                  
    `;
    bodyTable.appendChild(row);
  });
}
// const spinner = document.getElementById("loadingSpinner");

// spinner.style.display = "inline-block";
async function getLOA(fileName) {
  const spinner = document.getElementById("customSpinner");
  spinner.classList.remove("hidden");
  let response = await fetch(
    `http://localhost:8088/api/v1/recruiterVerification/LOA/${fileName}`
  );
  spinner.classList.add("hidden");
  const blob = await response.blob(); // tạo ra 1 đối tượng kiểu blob - bitnary large object
  const fileURL = URL.createObjectURL(blob); //tạo ra 1 URL tạm thời để mở trong tab mới

  // Mở tab mới với file
  window.open(fileURL, "_blank");

  //let row = document.createElement("tr");
}
async function getBL(fileName) {
  let response = await fetch(
    `http://localhost:8088/api/v1/recruiterVerification/BL/${fileName}`
  );
  const blob = await response.blob();
  const fileURL = URL.createObjectURL(blob);

  // Mở tab mới với file
  window.open(fileURL, "_blank");
}
async function resolveStatus(verifyId, status) {
  let response = await fetch(
    `http://localhost:8088/api/v1/recruiterVerification/status?verifyId=${verifyId}&status=${status}`,
    {
      method: "PUT",
    }
  );
  if (response.ok) {
    Swal.fire({
      title: "Success!",
      text: status == 3 ? `Verify success!.` : `Rejected`,
      icon: "success",
      showConfirmButton: false,
      timer: 1500,
    });
    setTimeout(() => {
      window.location.href = "../../pages/tables/pending_authentication.html";
    }, 1500);
  } else {
    alert("false");
  }
}
window.resolveStatus = resolveStatus; //gắn vào biến toàn cục
window.getLOA = getLOA;
window.getBL = getBL;
