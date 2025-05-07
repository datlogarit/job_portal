// js/api.js
const API_BASE = "http://localhost:8088/api/v1";

async function post(url, data) {
  const res = await fetch(`${API_BASE}${url}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  const contentType = res.headers.get("Content-Type");

  if (!res.ok) {
    const errorData = await res.json();
    throw new Error(errorData.message || "Có lỗi xảy ra");
  }
  return contentType && contentType.includes("application/json")
    ? await res.json()
    : await res.text();
}

async function get(url, data) {
  const res = await fetch(`${API_BASE}${url}`, {
    method: "GET",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  const contentType = res.headers.get("Content-Type");

  if (!res.ok) {
    const errorData = await res.json();
    throw new Error(errorData.message || "Có lỗi xảy ra");
  }
  return contentType && contentType.includes("application/json")
    ? await res.json()
    : await res.text();
}

export { post };
