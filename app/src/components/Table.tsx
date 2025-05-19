import { type ReactNode } from "react";
import clsx from "clsx";

export function Table(props: { className?: string; children?: ReactNode }) {
  const { className, children } = props;

  return (
    <table
      className={clsx(
        className,
        "tw-mb-0 tw-mt-4 tw-w-full",
        "[&_:is(th,td)]:tw-border-neutral-400",
        "[&_:is(th,td)]:tw-px-2.5",
        "[&_:is(th,td)]:tw-py-2",
        "[&_:is(th,td)]:tw-align-top",
        "[&_:is(th,td)]:tw-leading-tight",
        "[&_th]:tw-bg-neutral-100",
        "[&_th]:tw-text-[0.875rem]",
        "[&_td]:tw-text-[0.8125rem]",
        "[&_:is(th,td)_*]:tw-text-[length:inherit]",
      )}
    >
      {children}
    </table>
  );
}
