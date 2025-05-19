import { type MouseEventHandler } from "react";
import clsx from "clsx";

export function CenteredButton(props: {
  text: string;
  className?: string;
  onClick?: MouseEventHandler<HTMLButtonElement>;
}) {
  const { text, className, onClick } = props;

  return (
    <button
      className={clsx(
        className ?? "",
        "tw-mx-auto tw-mb-0 tw-block tw-rounded tw-bg-[#0071bc] tw-px-4 tw-py-1.5 tw-text-sm tw-text-white",
        "hover:tw-bg-[#005a96]",
        "focus:tw-bg-[#005a96]",
      )}
      type="button"
      onClick={onClick}
    >
      {text}
    </button>
  );
}
