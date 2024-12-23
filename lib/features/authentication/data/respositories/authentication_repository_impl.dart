import 'package:eram_express_shared/notification_service.dart';
import 'package:eram_express_shared/tokens/local/tokens_local_data_source.dart';
import '../../../customer/data/models/customer_model.dart';
import '../../../customer/data/repositories/customer_repository.dart';
import '../../presentation/objects/otp_verification_data.dart';
import '../models/verify_otp_response_model.dart';
import 'authentication_repository.dart';
import '../data_sources/authentication/remote/authentication_remote_data_source.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final CustomerRepository _customerRepository;
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;

  CustomerModel? _authenticatedCustomer;
  //final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthenticationRepositoryImpl({
    required CustomerRepository customerRepository,
    required NotificationService notificationService,
    //required SharedPreferencesHelper sharedPreferencesHelper,
    required AuthenticationRemoteDataSource authenticationRemoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  
  })  : _customerRepository = customerRepository,
        _authenticationRemoteDataSource = authenticationRemoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;
          //_sharedPreferencesHelper = sharedPreferencesHelper;

  @override
  Future<CustomerModel?> get authenticatedCustomer async {
    if (_authenticatedCustomer != null) return _authenticatedCustomer;
    final customer = await _customerRepository.getAuthenticatedCustomer();
    if (customer != null) _authenticatedCustomer = customer;
    return customer;

    /*
    final customer = await getCustomerModel();
    logger.debug("get model from pref ${customer}");
    if (customer == null) {
      logger.debug("enter to get cunstomer endpoint");
      final customer = await _customerRepository.getAuthenticatedCustomer();
      if (customer != null) {
        _authenticatedCustomer = customer;

        saveCustomerModel(customer!);
      }
    }
    */
  }

  @override
  Future<bool> isAuthenticated() async {
    final tokens = await _tokensLocalDataSource.accessToken;
    if (tokens != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  logout() async {
    await _authenticationRemoteDataSource.logOut();
    await _tokensLocalDataSource.clearTokens();
  }

  @override
  sendOtp(String phoneNumber) async {
    _authenticationRemoteDataSource.sendOtp(phoneNumber);
  }

  @override
  verifyOtp(OtpVerificationData data) async {
   

    final response = await _authenticationRemoteDataSource.verifyOtp(data,);

    savingToken(response.response);
    //saveCustomerModel(response.response.customer);
    return response;
  }

  @override
  void updateAuthenticatedCustomer(CustomerModel data) {
    //saveCustomerModel(data);
    _authenticatedCustomer = data;
  }

  @override
  void savingToken(VerifyOtpResponseModel response) async {
    await _tokensLocalDataSource.saveTokens(
      response.accessToken,
      response.refreshToken,
    );
  }
/*
  void saveCustomerModel(CustomerModel customer) async {
    await _sharedPreferencesHelper.saveModel(
        "customer", customer, (customer) => customer.toMap());
  }

  Future<CustomerModel?> getCustomerModel() async {
    final customer = await _sharedPreferencesHelper.getModel(
      'customer',
      (map) => CustomerModel.fromMap(map),
    );
    return customer;
  }
  */
}
