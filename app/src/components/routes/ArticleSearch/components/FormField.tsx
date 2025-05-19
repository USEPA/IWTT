import { type ReactElement, type ReactNode } from "react";
import clsx from "clsx";
// ---
import { InfoPopup } from "@/components/InfoPopup";
import { getNodeText } from "@/utilities";

export function FormField(props: {
  label: string | ReactElement;
  labelHidden?: boolean;
  info?: any;
  className?: string;
  children?: ReactNode;
}) {
  const { label, labelHidden, info, className, children } = props;

  return (
    <div className={clsx(className, "tw-w-full tw-p-2")}>
      {!labelHidden && (
        <div
          className={clsx(
            "tw-mb-1 tw-flex tw-min-h-4 tw-items-center tw-gap-1 tw-text-sm tw-font-bold tw-leading-none tw-text-neutral-700",
          )}
        >
          {label}
          {info && (
            <InfoPopup modalTitle={getNodeText(label)} modalBody={info} />
          )}
        </div>
      )}
      {children}
    </div>
  );
}
