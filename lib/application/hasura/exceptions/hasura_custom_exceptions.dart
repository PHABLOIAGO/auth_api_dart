import 'package:hasura_connect/hasura_connect.dart';

class HasuraCustomExceptions implements HasuraError {
  String _message;
  Request _request;

  HasuraCustomExceptions(this._message, this._request);

  @override
  String get message => _message;

  @override
  Request get request => _request;
}
