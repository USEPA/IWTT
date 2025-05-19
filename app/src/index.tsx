import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
// ---
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { App } from "@/components/App";
import "@/preflight.css"; // Tailwind CSS preflight styles, scoped to .twpf
import "@/index.css";

const container = document.getElementById("root") as HTMLElement;
const root = createRoot(container);

function Index() {
  return (
    <div className="twpf">
      <StrictMode>
        <ErrorBoundary>
          <App />
        </ErrorBoundary>
      </StrictMode>
    </div>
  );
}

root.render(<Index />);
