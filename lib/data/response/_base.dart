abstract class BaseResponse<T> {
  abstract int ?status;
  T toDomain();
}

abstract class BaseResponseField<T> {
  T toDomain();
}

