import { type ReactNode } from "react";
import clsx from "clsx";

export function SectionHeading(props: { children: ReactNode }) {
  const { children } = props;
  return (
    <h2
      className={clsx(
        "tw-m-4 tw-text-center tw-text-2xl tw-font-bold tw-leading-none",
      )}
    >
      {children}
    </h2>
  );
}
