class BaseModel {
  static List<T> listFromJson<T>(list, Function? decodeDataObject) {
    return List<T>.from(list.map((x) => decodeDataObject?.call(x)));
  }
}
