class DataRequest<T> {
  Function(T data) onSuccess;
  Function(int code, String message, dynamic) onFailure;
  Function(String error) onErrorHttp;

  DataRequest({this.onSuccess, this.onFailure,this.onErrorHttp});
}