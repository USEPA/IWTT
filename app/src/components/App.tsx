import { Provider } from "react-redux";
import {
  createBrowserRouter,
  createRoutesFromElements,
  redirect,
  Link,
  Route,
  RouterProvider,
} from "react-router-dom";
import clsx from "clsx";
// ---
import { store } from "@/redux/store";
import { AppLayout } from "@/components/AppLayout";
import { NotFound } from "@/components/routes/NotFound";
import { GuidedSearch } from "@/components/routes/GuidedSearch/GuidedSearch";
import { ArticleSearch } from "@/components/routes/ArticleSearch/ArticleSearch";
import { DownloadDatabase } from "@/components/routes/DownloadDatabase";
import { Glossary } from "@/components/routes/Glossary";
import { Help } from "@/components/routes/Help";
import { About } from "@/components/routes/About";
import { GuidedSearchHelp } from "@/components/routes/GuidedSearchHelp";
import { ArticleSearchHelp } from "@/components/routes/ArticleSearchHelp";
import { ArticleReportHelp } from "@/components/routes/ArticleReportHelp";
import { TreatmentTechnologies } from "@/components/routes/TreatmentTechnologies";
import { ArticleReport } from "@/components/routes/ArticleReport";
import { SubmitArticle } from "@/components/routes/SubmitArticle";

export const indexRoute = "/guided-search";

export function App() {
  const routes = createRoutesFromElements(
    <Route element={<AppLayout />}>
      <Route path="/" loader={(_args) => redirect(indexRoute)} />
      <Route path="/guided-search" element={<GuidedSearch />} />
      <Route path="/article-search" element={<ArticleSearch />} />
      <Route path="/download-database" element={<DownloadDatabase />} />
      <Route path="/glossary" element={<Glossary />} />
      <Route path="/help" element={<Help />} />
      <Route path="/about" element={<About />} />
      <Route path="/guided-search-help" element={<GuidedSearchHelp />} />
      <Route path="/article-search-help" element={<ArticleSearchHelp />} />
      <Route path="/article-report-help" element={<ArticleReportHelp />} />
      <Route
        path="/treatment-technologies"
        element={<TreatmentTechnologies />}
      />
      <Route path="/article-report/:reportId" element={<ArticleReport />} />
      {/* NOTE: /submit-article linked to from Drupal created contact form */}
      <Route path="/submit-article" element={<SubmitArticle />} />
      <Route path="*" element={<NotFound />} />
    </Route>,
  );

  const router = createBrowserRouter(routes, {
    basename: import.meta.env.VITE_APP_BASE_PATH,
  });

  return (
    <Provider store={store}>
      <RouterProvider router={router} />
    </Provider>
  );
}

export function IndustryInfoModalBody() {
  return (
    <p>
      Industry classifications in IWTT correspond to{" "}
      <Link to="/glossary#PSC" target="_blank" rel="noopener noreferrer">
        Point Source Categories (PSC)
      </Link>{" "}
      or descriptions of two-digit{" "}
      <Link to="/glossary#SIC" target="_blank" rel="noopener noreferrer">
        SIC codes
      </Link>
      .
    </p>
  );
}

export function TechnologyInfoModalBody() {
  return (
    <>
      <p>
        A wastewater treatment technology or unit process to reduce the
        concentration or quantity of pollutants in the discharged wastewater.
        Refer to{" "}
        <Link
          to="/treatment-technologies"
          target="_blank"
          rel="noopener noreferrer"
        >
          Treatment Technology Descriptions
        </Link>{" "}
        for the list of treatment technology classifications and descriptions in
        IWTT.
      </p>

      <p className={clsx("tw-mt-4")}>
        In some cases, the search term represents a grouping of technologies
        into a simplified naming convention for the purpose of searching IWTT.
        For example, a search for the technology “Membrane Filtration” may
        provide results for the technologies “Reverse Osmosis,”
        “Nanofiltration,” “Forward Osmosis,” “Membrane Distillation,” and
        “Micro- and Ultra-Membrane Filtration.”
      </p>
    </>
  );
}

export function PollutantInfoModalBody() {
  return (
    <p>
      A grouping of{" "}
      <Link to="/glossary#Parameter" target="_blank" rel="noopener noreferrer">
        parameters
      </Link>{" "}
      into a simplified naming convention for the purpose of searching IWTT. For
      example, a search for the pollutant “Nitrogen” may provide results for the
      parameters “Nitrogen, total” and “Nitrogen, organic.”
    </p>
  );
}
