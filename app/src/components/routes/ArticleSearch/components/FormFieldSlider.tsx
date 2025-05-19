import Slider from "react-slider";
import clsx from "clsx";
// ---
import { FormField } from "./FormField";

export function FormFieldSlider(props: {
  label: string;
  labelHidden?: boolean;
  info?: any;
  className?: string;
  options: number[];
  value: number[];
  onChange: (value: number[]) => void;
}) {
  const { label, labelHidden, info, className, options, value, onChange } =
    props;

  return (
    <FormField
      label={label}
      labelHidden={labelHidden}
      info={info}
      className={className}
    >
      <Slider
        className={clsx(
          "tw-mb-4 tw-mt-2 tw-h-3.5 tw-w-full",
          // slider bar
          "[&_.track]:tw-h-1.5",
          "[&_.track]:tw-rounded-full",
          "[&_.track]:tw-bg-neutral-300",
          "[&_.track-1]:!tw-bg-[#0071bc]",
          // slider handle
          "[&_.thumb]:tw-mt-4",
          "[&_.thumb]:tw-flex",
          "[&_.thumb]:tw-items-center",
          "[&_.thumb]:tw-justify-center",
          "[&_.thumb]:tw-w-3.5",
          "[&_.thumb]:tw-cursor-pointer",
          "[&_.thumb]:tw-whitespace-nowrap",
          "[&_.thumb]:tw-text-center",
          "[&_.thumb]:tw-text-xs",
          "[&_.thumb]:tw-font-bold",
          "[&_.thumb]:tw-text-neutral-700",
          // slider handle indicator dot
          "[&_.thumb::before]:tw-content-['']",
          "[&_.thumb::before]:tw-absolute",
          "[&_.thumb::before]:tw-rounded-full",
          "[&_.thumb::before]:tw-top-[-19px]",
          "[&_.thumb::before]:tw-left-0",
          "[&_.thumb::before]:tw-h-3.5",
          "[&_.thumb::before]:tw-w-3.5",
          "[&_.thumb::before]:tw-bg-neutral-400",
          // slider handle active indicator dot
          "[&_.thumb::after]:tw-content-['']",
          "[&_.thumb::after]:tw-absolute",
          "[&_.thumb::after]:tw-rounded-full",
          "[&_.thumb::after]:tw-top-[-24px]",
          "[&_.thumb::after]:tw-left-[-5px]",
          "[&_.thumb::after]:tw-h-6",
          "[&_.thumb::after]:tw-w-6",
          "[&_.thumb::after]:tw-bg-[#0071bc]",
          "[&_.thumb::after]:tw-transition-opacity",
          "[&_.thumb::after]:tw-duration-300",
          "[&_.thumb::after]:tw-opacity-0",
          "[&_.thumb.active::after]:tw-opacity-25",
          // slider handle focus outline
          "[&_.thumb:focus]:tw-outline-offset-8",
        )}
        ariaLabel={[`${label} (minimum value)`, `${label} (maximum value)`]}
        min={options[0]}
        max={options.slice(-1)[0]}
        minDistance={1}
        pearling
        value={value}
        onChange={(value) => onChange(value)}
        renderThumb={(props, state) => <div {...props}>{state.valueNow}</div>}
      />
    </FormField>
  );
}
