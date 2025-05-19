import clsx from "clsx";
// ---
import { FormField } from "./FormField";

export function FormFieldText(props: {
  label: string;
  info?: any;
  value: string;
  onChange: (value: string) => void;
}) {
  const { label, info, value, onChange } = props;

  return (
    <FormField label={label} info={info}>
      <input
        className={clsx(
          "tw-w-full tw-border tw-border-neutral-400 tw-p-2 tw-text-[0.8125rem] tw-leading-tight",
          "focus:tw-border-[#2684ff] focus:tw-shadow-[0_0_0_1px_#2684ff] focus:!tw-outline-none",
        )}
        type="text"
        aria-label={label}
        value={value}
        onChange={(ev) => onChange(ev.target.value)}
      />
    </FormField>
  );
}
