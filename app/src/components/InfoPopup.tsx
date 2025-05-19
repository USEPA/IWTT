import { Component } from "react";
import clsx from "clsx";
// ---
import { Modal } from "@/components/Modal";

type Props = {
  modalTitle: string;
  modalBody: any;
};

type State = {
  modalDisplayed: boolean;
};

export class InfoPopup extends Component<Props, State> {
  toggleModal: () => void;
  modalButton: HTMLButtonElement | undefined;

  constructor(props: Props) {
    super(props);

    this.state = {
      modalDisplayed: false,
    };

    this.toggleModal = () => {
      this.setState((_prevState) => ({
        modalDisplayed: !this.state.modalDisplayed,
      }));
    };
  }

  // only update component when state changes: important for keeping modalButton
  // from not stealing focus when it shouldn't (see componentDidUpdate below)
  shouldComponentUpdate(_nextProps: Props, nextState: State) {
    return this.state !== nextState;
  }

  componentDidUpdate() {
    const { modalDisplayed } = this.state;

    if (!modalDisplayed) {
      if (this.modalButton) this.modalButton.focus();
    }
  }

  render() {
    const { modalTitle, modalBody } = this.props;

    return (
      <div className={clsx("tw-flex tw-h-4")}>
        <button
          ref={(ref) => (this.modalButton = ref!)}
          className={clsx("tw-h-4 tw-w-4 tw-scale-[0.875] tw-rounded-lg")}
          type="button"
          title={`${modalTitle} info`}
          onClick={(_ev) => this.toggleModal()}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            viewBox="0 0 16 16"
          >
            <circle
              cx="8"
              cy="8"
              r="8"
              className={clsx(
                "tw-fill-neutral-500",
                "hover:tw-fill-neutral-700",
                "focus:tw-fill-neutral-700",
              )}
            />
            <path
              fill="#fff"
              d="M6.39,13.06l0-.07.31-1.75.48-3.47c0-.14,0-.23-.13-.27l-.64-.22.13-1H9.29l-.77,5.46c0,.21,0,.23.18.26l.62.09-.13,1Zm.9-8.79A1.23,1.23,0,0,1,8.62,2.94a.9.9,0,0,1,1,1A1.26,1.26,0,0,1,8.29,5.25.9.9,0,0,1,7.28,4.28Z"
            />
          </svg>
        </button>

        {this.state.modalDisplayed && (
          <div
            className={clsx(
              "[&_[data-id='iwtt-modal-contents']]:tw-max-w-lg",
              "[&_[data-id='iwtt-modal-body']]:tw-text-sm [&_[data-id='iwtt-modal-body']]:tw-font-normal",
              "[&_[data-id='iwtt-modal-body']_*]:tw-leading-[inherit]",
            )}
          >
            <Modal
              title={modalTitle}
              onCloseClick={() => this.toggleModal()}
              noScroll
            >
              {modalBody}
            </Modal>
          </div>
        )}
      </div>
    );
  }
}
