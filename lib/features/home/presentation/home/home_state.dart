class HomeState {
  final bool? isLoading;

  HomeState({
    this.isLoading = false,
  });

  HomeState copyWith({
    bool? isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
