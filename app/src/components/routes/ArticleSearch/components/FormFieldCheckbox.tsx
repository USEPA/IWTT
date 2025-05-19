import clsx from "clsx";
// ---
import { FormField } from "./FormField";

function formatText(text: string) {
  return text.replace(/\s+/g, "-").toLowerCase();
}

export function FormFieldCheckbox(props: {
  label: string;
  labelHidden?: boolean;
  info?: any;
  className?: string;
  disabled: boolean;
  checked: boolean;
  onChange: () => void;
}) {
  const { label, labelHidden, info, className, disabled, checked, onChange } =
    props;

  const id = `iwtt-field-${formatText(label)}`;

  return (
    <FormField
      label={label}
      labelHidden={labelHidden}
      info={info}
      className={className}
    >
      <span className={clsx("tw-flex tw-items-center")}>
        <input
          id={id}
          className={clsx("tw-h-4 tw-w-4")}
          type="checkbox"
          checked={checked}
          disabled={disabled}
          onChange={(_ev) => onChange()}
        />
        <label
          className={clsx(
            "tw-ml-2 tw-cursor-pointer tw-text-sm tw-leading-none tw-text-neutral-700",
          )}
          htmlFor={id}
        >
          {label}
        </label>
      </span>
    </FormField>
  );
}
