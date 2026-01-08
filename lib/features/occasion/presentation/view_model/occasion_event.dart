sealed class OccasionEvent {}

class GetAllOccasions extends OccasionEvent {}

class SelectOccasion extends OccasionEvent {
  final int index;
  SelectOccasion(this.index);
}
