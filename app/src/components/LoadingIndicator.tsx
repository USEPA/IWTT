import clsx from "clsx";
// ---
import icon from "@/components/LoadingIndicator.svg";

export function LoadingIndicator(props: { text: string }) {
  const { text } = props;

  return (
    <div
      className={clsx(
        "tw-mt-4 tw-bg-neutral-100 tw-px-4 tw-py-24 tw-text-center",
      )}
    >
      <p
        className={clsx(
          "tw-mb-4 tw-font-bold tw-uppercase tw-text-neutral-600",
        )}
      >
        {text}
      </p>
      <img
        className={clsx("tw-m-auto tw-h-12 tw-w-12 tw-animate-spin")}
        src={icon}
        alt=""
      />
    </div>
  );
}
