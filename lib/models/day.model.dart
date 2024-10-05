class DayModel {
  DateTime date;
  DateTime current;
  String label;
  bool status;

  // Constructor
  DayModel({
    required this.date,
    required this.current,
    required this.label,
    this.status = false, // Estado por defecto es false
  });

  // Método para mostrar la información del evento
  @override
  String toString() {
    return '';
  }

  bool isCurrent() {
    return this.current.day == this.date.day &&
        this.current.month == this.date.month &&
        this.current.year == this.date.year;
  }
}
