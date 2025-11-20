import { useEffect } from "react";
import { Outlet, useNavigate } from "react-router-dom";
import Sidebar from "../components/Sidebar";

export default function DashboardLayout() {
  const navigate = useNavigate();
  const usuarioId = localStorage.getItem("usuarioId");

  useEffect(() => {
    if (!usuarioId) {
      navigate("/");
    }
  }, [usuarioId, navigate]);

  if (!usuarioId) return null;

  return (
    <div className="flex h-screen">
      <aside className="w-64 bg-gray-100">
        <Sidebar />
      </aside>
      <main className="flex-1 p-8 overflow-auto">
        <Outlet />
      </main>
    </div>
  );
}
