class ApiResponse<T> {
  T value;

  ApiResponse(this.value);

  T getValue() {
    return value;
  }

  void setValue(T newValue) {
    value = newValue;
  }
}
