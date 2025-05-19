import { type ReactNode } from "react";
import clsx from "clsx";

export function Message(props: { children?: ReactNode }) {
  const { children } = props;

  return (
    <div
      className={clsx(
        "tw-bg-neutral-100 tw-p-8 tw-text-center",
        "[&_p:not(:first-child)]:tw-mt-4 [&_p]:tw-leading-tight",
      )}
    >
      {children}
    </div>
  );
}
