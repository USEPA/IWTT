import { type ReactElement } from "react";
import Select, {
  type GroupBase,
  type OptionsOrGroups,
  type MultiValue,
} from "react-select";
// ---
import { FormField } from "./FormField";
import { getNodeText } from "@/utilities";
import { type SelectOption } from "@/redux/index";

export function FormFieldSelect(props: {
  label: string | ReactElement;
  labelHidden?: boolean;
  info?: any;
  className?: string;
  disabled?: boolean;
  options: OptionsOrGroups<SelectOption, GroupBase<SelectOption>> | undefined;
  value: SelectOption[] | null;
  onChange: (selection: MultiValue<SelectOption>) => void;
}) {
  const {
    label,
    labelHidden,
    info,
    className,
    disabled,
    options,
    value,
    onChange,
  } = props;

  return (
    <FormField
      label={label}
      labelHidden={labelHidden}
      info={info}
      className={className}
    >
      <Select
        className="iwtt-select"
        classNamePrefix="iwtt-select"
        aria-label={getNodeText(label)}
        name={getNodeText(label)}
        placeholder={`Search by ${getNodeText(label)}...`}
        value={value}
        options={options}
        isMulti={true}
        isDisabled={disabled}
        onChange={(selection) => onChange(selection)}
      />
    </FormField>
  );
}
