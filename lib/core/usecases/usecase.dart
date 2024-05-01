abstract class Usecase<Type, Parem> {
  Future<Type> call({Parem parem});
}
