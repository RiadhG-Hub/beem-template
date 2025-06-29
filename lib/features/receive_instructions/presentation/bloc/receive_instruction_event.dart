abstract class ReceiveInstructionEvent {
  const ReceiveInstructionEvent();
}

class ReceiveInstruction extends ReceiveInstructionEvent {
  final bool instructionsType;
  const ReceiveInstruction(this.instructionsType);
}

class FilterReceiveInstruction extends ReceiveInstructionEvent {
  const FilterReceiveInstruction();
}
