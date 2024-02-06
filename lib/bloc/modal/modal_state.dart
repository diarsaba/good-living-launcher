part of 'modal_cubit.dart';

@immutable
sealed class ModalState extends Equatable {
  final Modal modal;

  const ModalState(this.modal);

  @override
  List<Object> get props => [];
}

class ModalInitialState extends ModalState {
  const ModalInitialState(super.modal);
}

class ModalUpdateState extends ModalState{
   const ModalUpdateState(super.modal);

  @override
  List<Object> get props => [modal];
}
// class ModalPiePickedState extends ModalState {
//   const ModalPiePickedState(super.modal);

//   @override
//   List<Object> get props => [modal];
// }

// class ModalAlarmPickedState extends ModalState {
//   const ModalAlarmPickedState(super.modal);

//   @override
//   List<Object> get props => [modal];
// }

// class ModalChoiseTimeState extends ModalState {
//   const ModalChoiseTimeState(super.modal);
//   @override
//   List<Object> get props => [modal];
// }

// class ModalChoiseDays extends ModalState {
//   const ModalChoiseDays(super.modal);
//   @override
//   List<Object> get props => [modal];
// }

// class ModalIconState extends ModalState {
//   const ModalIconState(super.modal);
//   @override
//   List<Object> get props => [modal];
// }
