class DuplicatedRecordException implements Exception {
  const DuplicatedRecordException();
}

class InvalidEmailOrPasswordException implements Exception {
  const InvalidEmailOrPasswordException();
}

class ConsultSlotTakenException implements Exception {
  const ConsultSlotTakenException();
}

class ConsultDuplicateInSameDateException implements Exception {
  const ConsultDuplicateInSameDateException();
}

class NotFoundException implements Exception {
  const NotFoundException();
}

class OverLimit implements Exception {
  const OverLimit();
}

class OverLimitMember implements Exception {
  const OverLimitMember();
}
