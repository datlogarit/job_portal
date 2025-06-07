var notyf = new Notyf({
  duration: 2500,
  position: {
    x: "right", // left | center | right
    y: "top",
  },
  dismissible: true, // Có nút tắt hay không
});

let currentPage = 0;
let totalPages = 0;

document.addEventListener("DOMContentLoaded", () => {
  fetchUser();
});

//nếu đang ở trang nào thì hiển thị 2 trang kề nó, nếu là 1 thì lấy 2 trang đằng trước, nếu là n thì lấy 2 trang đằng sau

function fetchUser(page = 0) {
  currentPage = page;
  fetch(`http://localhost:8088/api/v1/user?page=${page}&limit=25`).then(
    (response) => {
      if (response.ok) {
        response.json().then((response) => {
          renderUsers(response["users"]);
          totalPages = response["total Page"];
          renderPagination();
        });
      } else {
        alert("Error when fetch data");
      }
    }
  );
}

function renderUsers(users) {
  let tableBody = document.getElementById("tableBody");
  tableBody.innerHTML = "";
  users.forEach((user) => {
    let row = document.createElement("tr");
    row.innerHTML = `
    <td class="py-1">
        <img style="border-radius: unset; width: 40px;height: fit-content;"
        src="http://localhost:8088/api/v1/user/images/${user.urlAvatar}"
        alt="image" />
    </td>
    <td>
        ${user.name}
    </td>
    <td>
        ${user.email}
    </td>
    <td>
        ${user.phoneNumber}
    </td>

    <td >
       <div style="display: flex; align-items: center; gap: 8px;">
        ${
          user.role === "applicant"
            ? ` <div style="width: 10px;height: 10px;background: #3B82F6; border-radius: 50%;"></div>`
            : ` <div style="width: 10px;height: 10px;background: #F97316; border-radius: 50%;"></div>`
        }
       <div>${formatText(user.role, 20)}</div>
       </div>
    </td>

    <td>
       ${
         user.isActive
           ? ` <button onclick="changeBanUser(${user.id}, 0)" style="min-width: 100px;" type="button"
            class="btn btn-danger">BAN</button>`
           : `<button onclick="changeBanUser(${user.id}, 1)" style="min-width: 100px;" type="button"
            class="btn btn-info">UNBAN</button>`
       }

    </td>
    `;
    tableBody.appendChild(row);
  });
}
function changeBanUser(userId, status) {
  let http;
  if (!status) {
    http = `http://localhost:8088/api/v1/user/BanUser/${userId}`;
  } else {
    http = `http://localhost:8088/api/v1/user/UNBanUser/${userId}`;
  }
  fetch(http, {
    method: "PUT",
    body: { "Content-type": "application/json" },
  }).then((response) => {
    if (response.ok) {
      Swal.fire({
        title: "Success!",
        text: status ? `UNBAN User successfully!.` : `BAN User successfully!`,
        icon: "success",
        showConfirmButton: false,
        timer: 2000,
      });
      setTimeout(() => {
        window.location.href = "../../pages/tables/user-manager.html";
      }, 2000);
    }
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
      fetchUser(i);
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
      searchUser(keySearch);
    } else {
      alert("Please enter the key search before summit");
    }
  }
});

function searchUser(email) {
  fetch(`http://localhost:8088/api/v1/user/findByEmail/${email}`).then(
    (response) => {
      if (response.ok) {
        response.json().then((response) => {
          response;
          const userArray = [response];
          renderUsers(userArray);
        });
      } else {
        response.json().then((response) => {
          notyf.error(response["message"]);
        });
      }
    }
  );
}
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
