import clsx from "clsx";
// ---
import { FormField } from "./FormField";

function formatText(text: string) {
  return text.replace(/\s+/g, "-").toLowerCase();
}

export function FormFieldCheckboxGroup(props: {
  label: string;
  labelHidden?: boolean;
  info?: any;
  className?: string;
  checkboxes: string[];
  selectedCheckboxes: string[];
  onChange: (checkbox: string) => void;
}) {
  const {
    label,
    labelHidden,
    info,
    className,
    checkboxes,
    selectedCheckboxes,
    onChange,
  } = props;

  return (
    <FormField
      label={label}
      labelHidden={labelHidden}
      info={info}
      className={className}
    >
      <div className={clsx("tw-mb-2 tw-flex tw-gap-4")}>
        {checkboxes.map((checkbox) => {
          const id = `iwtt-field-${formatText(label)}-${formatText(checkbox)}`;

          return (
            <span key={checkbox} className={clsx("tw-flex tw-items-center")}>
              <input
                id={id}
                className={clsx("tw-h-4 tw-w-4")}
                type="checkbox"
                checked={selectedCheckboxes.includes(checkbox)}
                onChange={(_ev) => onChange(checkbox)}
              />
              <label
                className={clsx(
                  "tw-ml-2 tw-cursor-pointer tw-text-sm tw-leading-none tw-text-neutral-700",
                )}
                htmlFor={id}
              >
                {checkbox}
              </label>
            </span>
          );
        })}
      </div>
    </FormField>
  );
}
