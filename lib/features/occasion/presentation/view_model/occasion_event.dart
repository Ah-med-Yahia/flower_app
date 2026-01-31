sealed class OccasionEvent {}

class GetAllOccasions extends OccasionEvent {
  final String? initialOccasionId;
  GetAllOccasions({this.initialOccasionId});
}

class SelectOccasion extends OccasionEvent {
  final int index;
  SelectOccasion(this.index);
}

class GetOccasionProducts extends OccasionEvent {
  final String occasionId;
  GetOccasionProducts(this.occasionId);
}
