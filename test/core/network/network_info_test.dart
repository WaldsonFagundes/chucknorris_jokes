import 'package:chucknorris_jokes/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';


@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])

void main(){

  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
   mockInternetConnectionChecker = MockInternetConnectionChecker();
   networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test ("Should forward the call to InternetConnectionChecker.hasConnection", () async{
      final testHasConnectionFuture = await  Future.value(true);

      when(mockInternetConnectionChecker.hasConnection)
      .thenAnswer((_) async =>  testHasConnectionFuture);

      final result = await networkInfoImpl.isConnected;

      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, testHasConnectionFuture);

        });

  });



}