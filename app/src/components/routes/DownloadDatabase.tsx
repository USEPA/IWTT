import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

export function DownloadDatabase() {
  return (
    <section className={clsx("tw-prose tw-max-w-none tw-p-4", "print:tw-p-0")}>
      <SectionHeading>Download Database</SectionHeading>

      <p>
        The IWTT data set is available for download as a compressed ZIP file
        containing several comma-delimited text files. The IWTT data dictionary
        is available for download as an XLSX file and provides a description of
        the fields in the IWTT data set.
      </p>

      <ul>
        <li>
          <a href="./assets/IWTT-DATA-DOWNLOAD.zip" download>
            IWTT Data Set (ZIP)
          </a>{" "}
          <span
            className={clsx(
              "tw-ml-1 tw-whitespace-nowrap tw-text-sm tw-text-neutral-500",
            )}
          >
            (222 K, April 2024)
          </span>
        </li>
        <li>
          <a
            href="./assets/IWTT_Data_Element_Dictionary_03222024.xlsx"
            download
          >
            IWTT Data Dictionary (XLSX)
          </a>{" "}
          <span
            className={clsx(
              "tw-ml-1 tw-whitespace-nowrap tw-text-sm tw-text-neutral-500",
            )}
          >
            (31 K, April 2024)
          </span>
        </li>
      </ul>
    </section>
  );
}
