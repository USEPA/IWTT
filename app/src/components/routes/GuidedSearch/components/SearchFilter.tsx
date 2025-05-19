import clsx from "clsx";
// ---
import { useAppDispatch, useAppSelector } from "@/redux/index";

export function SearchFilter({ label }: { label: string }) {
  const searchFilter = useAppSelector(
    ({ guidedSearch }) => guidedSearch.filter,
  );
  const dispatch = useAppDispatch();

  const id = `guided-search-filter-${label.replace(/\s+/g, "-").toLowerCase()}`;

  return (
    <span className={clsx("tw-m-1 tw-flex tw-items-center")}>
      <input
        id={id}
        className={clsx("tw-h-4 tw-w-4 tw-rounded-full")}
        type="radio"
        name="guided-search-filter"
        checked={searchFilter === label ? true : false}
        onChange={(_ev) => {
          dispatch({
            type: "guided-search/set-filter",
            payload: { filter: label },
          });
        }}
      />
      <label
        className={clsx("tw-ml-2 tw-cursor-pointer tw-text-sm")}
        htmlFor={id}
      >
        {label}
      </label>
    </span>
  );
}
