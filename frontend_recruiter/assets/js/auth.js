// // js/auth.js
// import { post } from "./api.js";

// export async function loginRecruiter(email, password) {
//   const user = await post("/recruiter/login", { email, password });
//   user.userId.password = `${password}`;
//   localStorage.setItem("user", JSON.stringify(user));
//   return user;
// }

// // js/auth.js
// export async function registerRecruiter(name, email, password) {
//   const res = await post("/recruiter", {
//     name,
//     email,
//     password,
//   });
//   return res;
// }

// export function getCurrentUser() {
//   return JSON.parse(localStorage.getItem("user"));
// }

// export function logout() {
//   localStorage.removeItem("user");
// }
