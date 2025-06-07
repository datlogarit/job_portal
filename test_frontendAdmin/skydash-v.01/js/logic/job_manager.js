let currentPage = 0;
let totalPages = 0;

document.addEventListener("DOMContentLoaded", () => {
  fetchJob();
});

//nếu đang ở trang nào thì hiển thị 2 trang kề nó, nếu là 1 thì lấy 2 trang đằng trước, nếu là n thì lấy 2 trang đằng sau

function fetchJob(page = 0) {
  currentPage = page;
  fetch(
    `http://localhost:8088/api/v1/job/allJobAdmin?page=${page}&limit=25`
  ).then((response) => {
    if (response.ok) {
      response.json().then((response) => {
        renderJob(response["job"]);
        totalPages = response["total Page"];
        renderPagination();
      });
    } else {
      alert("Error when fetch data");
    }
  });
}

function renderJob(jobs) {
  let tableBody = document.getElementById("tableBody");
  tableBody.innerHTML = "";
  jobs.forEach((job) => {
    let row = document.createElement("tr");
    row.innerHTML = `
    <td class="py-1">
       ${formatText(job.title, 35)}
    </td>
    <td>
        ${job.postedBy.userId.email}
    </td>
    <td>
        ${formatText(job.postedBy.companyId.name, 25)}
    </td>
    <td>
        ${formatDateTime(job.createdAt)}
    </td>

    <td>
        ${job.status}
    </td>

    <td>
       ${
         job.isLock
           ? ` <button onclick="changeLockJob(${
               job.id
             }, ${0})" style="min-width: 100px;" type="button"
            class="btn btn-info">UNBAN</button>`
           : `<button onclick="changeLockJob(${
               job.id
             }, ${1})" style="min-width: 100px;" type="button"
            class="btn btn-danger">BAN</button>`
       }

    </td>
    `;
    tableBody.appendChild(row);
  });
}

function renderPagination() {
  let pagination = document.getElementById("pagination");
  pagination.innerHTML = "";

  // Nút Previous
  const prevItem = document.createElement("li");
  prevItem.className = `page-item ${currentPage === 0 ? "disabled" : ""}`;
  prevItem.innerHTML = `
    <a class="page-link" href="#" aria-label="Previous">
      <span aria-hidden="true">&laquo;</span>
    </a>`;
  prevItem.addEventListener("click", (e) => {
    e.preventDefault();
    if (currentPage > 0) fetchJob(currentPage - 1);
  });
  pagination.appendChild(prevItem); //in ra được nút previous

  // Tính dải trang cần hiển thị
  //đảm bảo không vượt quá 0 và totalPage - 1 trang
  let start = Math.max(0, currentPage - 1); //start sẽ là currentPage -1 và nhỏ nhất phải là 0
  let end = Math.min(totalPages - 1, currentPage + 1); //end sẽ là currenpage + 1 và lớn nhất là totalPage -1

  if (currentPage === 0) {
    //nếu totalPage bằng phải bằng 2 hoặc lớn nhất là total page -1
    end = Math.min(totalPages - 1, 2);
  } else if (currentPage === totalPages - 1) {
    //nếu current page = total page -1 thì max là total thì phải bắt đầu từ total page -3 và phải lớn hơn 0
    start = Math.max(0, totalPages - 3);
  }

  for (let i = start; i <= end; i++) {
    const pageItem = document.createElement("li");
    pageItem.className = `page-item ${i === currentPage ? "active" : ""}`;
    pageItem.innerHTML = `<a class="page-link" href="#">${i + 1}</a>`;
    pageItem.addEventListener("click", (e) => {
      e.preventDefault();
      fetchJob(i);
    });
    pagination.appendChild(pageItem);
  }

  // Nút Next
  const nextItem = document.createElement("li");
  nextItem.className = `page-item ${
    currentPage === totalPages - 1 ? "disabled" : ""
  }`;
  nextItem.innerHTML = `
    <a class="page-link" href="#" aria-label="Next">
      <span aria-hidden="true">&raquo;</span>
    </a>`;
  nextItem.addEventListener("click", (e) => {
    e.preventDefault();
    if (currentPage < totalPages - 1) fetchJob(currentPage + 1);
  });
  pagination.appendChild(nextItem);
}

let navbar_search_input = document.getElementById("navbar-search-input");
navbar_search_input.addEventListener("keypress", (e) => {
  //   e.preventDefault();
  if (e.key === "Enter") {
    //Gửi dữ liệu lên db
    let keySearch = document.getElementById("navbar-search-input").value;
    if (keySearch != null && keySearch != "") {
      pagination.innerHTML = "";
      searchJob(keySearch);
    } else {
      alert("Please enter the key search before summit");
    }
  }
});

function searchJob(keySearch) {
  fetch(
    `http://localhost:8088/api/v1/job/searchJobAdmin?page=0&limit=100&search_keyword=${keySearch}`
  ).then((response) => {
    if (response.ok) {
      response.json().then((response) => {
        renderJob(response);
      });
    } else {
      alert("Error when fetch data");
    }
  });
}

async function changeLockJob(jobId, isLock) {
  let response = await fetch(
    `http://localhost:8088/api/v1/job/lock/${jobId}?isLock=${isLock}`,
    {
      method: "PUT",
    }
  );
  if (response.ok) {
    Swal.fire({
      title: "Success!",
      text: isLock ? `BAN post successfully!.` : `UNBAN post successfully!`,
      icon: "success",
      showConfirmButton: false,
      timer: 2000,
    });
    setTimeout(() => {
      window.location.href = "../../pages/tables/job-manager.html";
    }, 2000);
  }
}
// function filterJobBaned(page = 0) {
//   currentPage = page;
//   fetch(
//     `http://localhost:8088/api/v1/job/allJobAdmin?page=${page}&limit=25`
//   ).then((response) => {
//     if (response.ok) {
//       response.json().then((response) => {
//         renderJob(response["job"]);
//         totalPages = response["total Page"];
//         renderPagination();
//       });
//     } else {
//       alert("Error when fetch data");
//     }
//   });
// }
function formatText(str, maxLength) {
  if (!str) return "";

  // Viết hoa chữ cái đầu tiên
  const capitalized = str.charAt(0).toUpperCase() + str.slice(1);

  // Nếu độ dài nhỏ hơn hoặc bằng maxLength → giữ nguyên
  if (capitalized.length <= maxLength) {
    return capitalized;
  }

  // Nếu vượt quá, cắt và thêm '...'
  return capitalized.slice(0, maxLength - 3) + "...";
}
function formatDateTime(dateString) {
  if (!dateString) return "";

  const date = new Date(dateString);

  const day = String(date.getDate()).padStart(2, "0");
  const month = String(date.getMonth() + 1).padStart(2, "0"); // tháng bắt đầu từ 0
  const year = date.getFullYear();

  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");

  // Trả về định dạng "dd/mm/yyyy HH:MM"
  return `${day}/${month}/${year} ${hours}:${minutes}`;
}
