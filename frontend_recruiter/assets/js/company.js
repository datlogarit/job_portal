//   const tax_code = document.getElementById("tax_code").value;
//   const company_name = document.getElementById("company_name").value;
//   const website_company = document.getElementById("website_company").value;
//   const scale_company = document.getElementById("scale_company").value;
//   const address_company = document.getElementById("address_company").value;
//   const email_company = document.getElementById("email_company").value;
//   const phone_number = document.getElementById("phone_number").value;
//   //   const description_company = tinymce.get("description_company").getContent(); // Lấy nội dung từ TinyMCE
//   const logo = document.getElementById("logoUpload").files[0];
const user = JSON.parse(localStorage.getItem("user"));
const notyf = new Notyf({
  duration: 2500,
  position: { x: "right", y: "top" },
  dismissible: true,
});
document.addEventListener("DOMContentLoaded", () => {
  // fetch data, đổ dữ liệu lên các trường
  fetInfoCompany();
});

function fetInfoCompany() {
  fetch(`http://localhost:8088/api/v1/company/${user.companyId.id}`)
    .then((response) => {
      return response.json();
    })
    .then((company) => {
      document.getElementById("tax_code").value = company.taxCode;
      document.getElementById("company_name").value = company.name;
      document.getElementById("website_company").value = company.website;
      document.getElementById("address_company").value = company.location;
      document.getElementById("email_company").value = company.email;
      document.getElementById("phone_number").value = company.hotline;
      tinymce.get("description_company").setContent(company.introduction);
    });
}
function updateCompany() {
  const tax_code = document.getElementById("tax_code").value;
  const company_name = document.getElementById("company_name").value;
  const website_company = document.getElementById("website_company").value;
  const scale_company = document.getElementById("scale_company").value;
  const address_company = document.getElementById("address_company").value;
  const email_company = document.getElementById("email_company").value;
  const phone_number = document.getElementById("phone_number").value;
  const description_company = tinymce.get("description_company").getContent();
  fetch(`http://localhost:8088/api/v1/company/${user.companyId.id}`, {
    method: "PUT",
    headers: { "Content-type": "application/json" },
    body: JSON.stringify({
      tax_code: tax_code,
      name: company_name,
      website: website_company,
      scale: scale_company,
      address: address_company,
      email: email_company,
      hotline: phone_number,
      introduction: description_company,
    }),
  }).then((result) => {
    if (result.ok) {
      Swal.fire({
        title: "Success!",
        text: `Update company success!.`,
        icon: "success",
        showConfirmButton: false,
        timer: 1500,
      });
      setTimeout(() => {
        window.location.href = "../../index.html";
      }, 1500);
    }
  });
}
