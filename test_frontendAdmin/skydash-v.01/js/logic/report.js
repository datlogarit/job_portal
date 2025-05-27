import { Helper } from "../helper/helper.js";

document.addEventListener("DOMContentLoaded", () => {
  fetchReport();
});
async function fetchReport() {
  let response = await fetch(`http://localhost:8088/api/v1/report`);
  if (response.ok) {
    let reports = await response.json();
    renderReport(reports);
  } else {
    alert("False");
  }
}
function renderReport(reports) {
  let bodyTable = document.getElementById("bodyTable");
  bodyTable.innerHTML = "";
  reports.forEach((report) => {
    let row = document.createElement("tr");
    row.innerHTML = `
        <td class="py-1">
            ${report.reporter.userId.email}
        </td>
        <td>
         ${Helper.formatText(report.reportedJob.title, 25)}
            
        </td>
        <td>
             ${report.reportedJob.postedBy.userId.email}
        </td>
        <td style="word-wrap: break-word;">
            ${report.reason}
        </td>
        <td>
            <button onclick="banUser(${
              report.id
            })" type="button" class="btn btn-inverse-danger btn-icon">
                <!-- <i class="ti-location-pin"></i> -->
                <i class="fa-solid fa-user-slash"></i>
            </button>
            <button onclick="banPost(${
              report.id
            })" type="button" class="btn btn-inverse-danger btn-icon">
                <!-- <i class="ti-location-pin"></i> -->
                <i class="fa-solid fa-file-excel"></i>
            </button>
            <button  onclick="skipReport(${
              report.id
            })" type="button" class="btn btn-inverse-info btn-icon">
                <i class="fa-solid fa-forward"></i>
            </button>
        </td>                            
    `;
    bodyTable.appendChild(row);
  });
}
async function banUser(reportId) {
  let response = await fetch(
    `http://localhost:8088/api/v1/report/BANUser?reportId=${reportId}`,
    {
      method: "PUT",
    }
  );
  if (response.ok) {
    Swal.fire({
      title: "Success!",
      text: `BAN user successfuly!.`,
      icon: "success",
      showConfirmButton: false,
      timer: 2000,
    });
    setTimeout(() => {
      window.location.href = "../../pages/tables/report-table.html";
    }, 2000);
  }
}
async function banPost(reportId) {
  let response = await fetch(
    `http://localhost:8088/api/v1/report/BANPost?reportId=${reportId}`,
    {
      method: "PUT",
    }
  );
  if (response.ok) {
    Swal.fire({
      title: "Success!",
      text: `BAN post successfuly!.`,
      icon: "success",
      showConfirmButton: false,
      timer: 2000,
    });
    setTimeout(() => {
      window.location.href = "../../pages/tables/report-table.html";
    }, 2000);
  }
}
async function skipReport(reportId) {
  let response = await fetch(
    `http://localhost:8088/api/v1/report?reportId=${reportId}&statusSolve=1`,
    {
      method: "PUT",
    }
  );
  if (response.ok) {
    Swal.fire({
      title: "Success!",
      text: `ignored the report!.`,
      icon: "success",
      showConfirmButton: false,
      timer: 2000,
    });
    setTimeout(() => {
      window.location.href = "../../pages/tables/report-table.html";
    }, 2000);
  }
}
window.banPost = banPost;
window.banUser = banUser;
window.skipReport = skipReport;
