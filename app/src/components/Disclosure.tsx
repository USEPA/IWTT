import { type ReactNode } from "react";
import clsx from "clsx";

export function Details(props: { className?: string; children?: ReactNode }) {
  const { className, children } = props;

  return (
    <details className={clsx(className, "tw-mt-4", "tw-group")} open>
      {children}
    </details>
  );
}

export function Summary(props: { children?: ReactNode }) {
  const { children } = props;

  return (
    <summary
      className={clsx(
        "tw-relative tw-cursor-pointer tw-bg-neutral-500 tw-p-2 tw-text-sm tw-text-white",
        "after:tw-absolute",
        "after:tw-right-2.5",
        "after:tw-top-1",
        "after:tw-text-xl",
        "after:tw-font-bold",
        "after:tw-content-['+']",
        "group-open:after:tw-top-0.5",
        "group-open:after:tw-content-['–']",
        "print:tw-border-b",
        "print:tw-font-bold",
        "print:after:tw-hidden",
      )}
    >
      {children}
    </summary>
  );
}
