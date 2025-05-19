import { useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
// ---
import { indexRoute } from "@/components/App";

export function NotFound() {
  const { pathname } = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    /* NOTE: redirect old article report routes (e.g. "/article-report-123") */
    if (pathname.startsWith("/article-report-")) {
      const [_, reportId] = pathname.split("/article-report-");
      navigate(`/article-report/${reportId}`);
    } else {
      navigate(indexRoute);
    }
  });

  return null;
}
