import { type ReactNode, Component } from "react";
import { XMarkIcon } from "@heroicons/react/16/solid";
import clsx from "clsx";

type Props = {
  title: string;
  children?: ReactNode;
  noScroll?: boolean;
  onCloseClick: () => void;
};

export class Modal extends Component<Props> {
  modalCloseButton: HTMLButtonElement | undefined;
  modalContents: HTMLDivElement | undefined;

  componentDidMount() {
    const { noScroll } = this.props;

    if (this.modalCloseButton) {
      this.modalCloseButton.focus();
    }

    // noScroll boolean prop prevents window from scrolling to modal
    if (noScroll) {
      return;
    } else {
      // scroll modal 'contents' into view (good for tall pages, as modal will
      // be displayed vertical centered over page's contents)
      if (this.modalContents) {
        this.modalContents.scrollIntoView();
        window.scrollBy(0, -16);
      }
    }
  }

  render() {
    const { title, children, onCloseClick } = this.props;

    return (
      <div
        className={clsx(
          "tw-absolute tw-left-0 tw-top-0 tw-z-10 tw-h-full tw-w-full tw-bg-black/65",
          "print:!tw-bg-black",
        )}
        data-id="iwtt-modal"
        onClick={(ev) => {
          if ((ev.target as HTMLElement).dataset.id === "iwtt-modal") {
            onCloseClick();
          }
        }}
      >
        <div
          className={clsx(
            "tw-absolute tw-right-1/2 tw-top-1/2 tw-z-[100] tw-max-h-[calc(100%-2rem)] tw-w-[calc(100%-2rem)] tw-translate-x-1/2 tw-translate-y-[-50%] tw-overflow-auto tw-bg-white tw-text-left tw-shadow-md",
            "print:!tw-bg-white",
          )}
          data-id="iwtt-modal-contents"
          ref={(ref) => (this.modalContents = ref!)}
        >
          <header className={clsx("tw-m-4")}>
            <h2 className={clsx("tw-border-b tw-text-lg tw-leading-none")}>
              {title}
            </h2>
            <button
              ref={(ref) => (this.modalCloseButton = ref!)}
              className={clsx(
                "tw-absolute tw-right-0 tw-top-0 tw-cursor-pointer tw-bg-black/75 tw-p-1.5 tw-text-white tw-opacity-50",
                "hover:tw-opacity-75",
                "focus:tw-opacity-75",
              )}
              type="button"
              title="Close modal"
              onClick={(_ev) => onCloseClick()}
            >
              <span className="tw-sr-only">Close modal</span>
              <XMarkIcon className="tw-h-4 tw-w-4" aria-hidden="true" />
            </button>
          </header>

          <section className={clsx("tw-m-4")} data-id="iwtt-modal-body">
            {children}
          </section>
        </div>
      </div>
    );
  }
}
