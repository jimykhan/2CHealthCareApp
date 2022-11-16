import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/s3-services/src/emum.dart';
import 'package:twochealthcare/services/s3-services/src/policy.dart';
import 'package:twochealthcare/services/s3-services/src/utils.dart';
import 'package:path/path.dart' as path;

class S3CrudService{
  String accessKey = 'AKIAYVREBNGIADT7AAHB';
  String secretKey = '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';
  String bucket = 'healthforce-data-dev';
  Dio? _dio;
  DioServices? _dioServices;
  ProviderReference? _ref;
   S3CrudService({ProviderReference? ref}){
    _dio = Dio();
    _dioServices = ref?.read(dioServicesProvider);

  }

  /// Upload a file, returning the file's public URL on success.
   Future<String?> uploadFile({
    /// AWS access key
    // required String accessKey,
    //
    // /// AWS secret key
    // required String secretKey,
    //
    // /// The name of the S3 storage bucket to upload  to
    // required String bucket,

    /// The file to upload
    required File file,

    /// The key to save this file as. Will override destDir and filename if set.
    String? key,

    /// The path to upload the file to (e.g. "uploads/public"). Defaults to the root "directory"
    String destDir = 'voice-message',

    /// The AWS region. Must be formatted correctly, e.g. us-west-1
    String region = 'us-east-1',

    /// Access control list enables you to manage access to bucket and objects
    /// For more information visit [https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html]
    ACL acl = ACL.private,

    /// The filename to upload as. If null, defaults to the given file's current filename.
    String? filename,

    /// The content-type of file to upload. defaults to binary/octet-stream.
    String contentType = 'binary/octet-stream',
  }) async {
    final endpoint = 'https://$bucket.s3.$region.amazonaws.com';
    final uploadKey = key ?? '$destDir/${filename ?? path.basename(file.path)}';

    // final stream = http.ByteStream(Stream.castFrom(file.openRead()));
    final length = await file.length();



    // final uri = Uri.parse(endpoint);
    final multiPartFile = await MultipartFile.fromFile(file.path,filename: path.basename(file.path));
    // final req = http.MultipartRequest("POST", uri);
    // final multipartFile = http.MultipartFile('file', stream, length,
    //     filename: path.basename(file.path));
    final policy = Policy.fromS3PresignedPost(
        uploadKey, bucket, accessKey, 15, length, acl,
        region: region);
    final signingKey =
    SigV4.calculateSigningKey(secretKey, policy.datetime, region, 's3');
    final signature = SigV4.calculateSignature(signingKey, policy.encode());
    var formData = FormData.fromMap({
      'key': policy.key,
      'acl': aclToString(acl),
      'X-Amz-Credential': policy.credential,
      'X-Amz-Algorithm' : 'AWS4-HMAC-SHA256',
      'X-Amz-Date' : policy.datetime,
      'Policy' : policy.encode(),
      'X-Amz-Signature' : signature,
      'Content-Type' : contentType,
      'file': multiPartFile
    });
    // req.files.add(multipartFile);
    // req.fields['key'] = policy.key;
    // req.fields['acl'] = aclToString(acl);
    // req.fields['X-Amz-Credential'] = policy.credential;
    // req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    // req.fields['X-Amz-Date'] = policy.datetime;
    // req.fields['Policy'] = policy.encode();
    // req.fields['X-Amz-Signature'] = signature;
    // req.fields['Content-Type'] = contentType;

    try {
      // final res = await req.send();
      Response? res = await _dio?.post(endpoint,data: formData);

      if (res?.statusCode == 204) {
        // return '$endpoint/$uploadKey';
        return uploadKey;
      }
    } catch (e) {
      print('Failed to upload to AWS, with exception:');
      print(e);
      return null;
    }
  }

  Future<String?> downLoadFile({
    /// AWS access key
    // required String accessKey,
    //
    // /// AWS secret key
    // required String secretKey,
    //
    // /// The name of the S3 storage bucket to upload  to
    // required String bucket,

    /// The file to upload
    required File file,

    /// The key to save this file as. Will override destDir and filename if set.
    String? key,

    /// The path to upload the file to (e.g. "uploads/public"). Defaults to the root "directory"
    String destDir = 'voice-message',

    /// The AWS region. Must be formatted correctly, e.g. us-west-1
    String region = 'us-east-1',

    /// Access control list enables you to manage access to bucket and objects
    /// For more information visit [https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html]
    ACL acl = ACL.private,

    /// The filename to upload as. If null, defaults to the given file's current filename.
    String? filename,

    /// The content-type of file to upload. defaults to binary/octet-stream.
    String contentType = 'binary/octet-stream',
  }) async {
    final endpoint = 'https://$bucket.s3.$region.amazonaws.com';
    final uploadKey = key ?? '$destDir/${filename ?? path.basename(file.path)}';

    // final stream = http.ByteStream(Stream.castFrom(file.openRead()));
    final length = await file.length();



    // final uri = Uri.parse(endpoint);
    final multiPartFile = await MultipartFile.fromFile(file.path,filename: path.basename(file.path));
    // final req = http.MultipartRequest("POST", uri);
    // final multipartFile = http.MultipartFile('file', stream, length,
    //     filename: path.basename(file.path));
    final policy = Policy.fromS3PresignedPost(
        destDir, bucket, accessKey, 15, length, acl,
        region: region);
    final signingKey =
    SigV4.calculateSigningKey(secretKey, policy.datetime, region, 's3');
    final signature = SigV4.calculateSignature(signingKey, policy.encode());

    var formData = FormData.fromMap({
      'key': policy.key,
      'acl': aclToString(acl),
      'X-Amz-Credential': policy.credential,
      'X-Amz-Algorithm' : 'AWS4-HMAC-SHA256',
      'X-Amz-Date' : policy.datetime,
      'Policy' : policy.encode(),
      'X-Amz-Signature' : signature,
      'Content-Type' : contentType,
      'file': multiPartFile
    });
    // req.files.add(multipartFile);
    // req.fields['key'] = policy.key;
    // req.fields['acl'] = aclToString(acl);
    // req.fields['X-Amz-Credential'] = policy.credential;
    // req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    // req.fields['X-Amz-Date'] = policy.datetime;
    // req.fields['Policy'] = policy.encode();
    // req.fields['X-Amz-Signature'] = signature;
    // req.fields['Content-Type'] = contentType;

    try {
      // final res = await req.send();
      Response? res = await _dio?.post(endpoint,data: formData);

      if (res?.statusCode == 204) {
        // return '$endpoint/$uploadKey';
        return uploadKey;
      }
    } catch (e) {
      print('Failed to upload to AWS, with exception:');
      print(e);
      return null;
    }
  }

  Future<String> getPublicUrl(privateUrl)async{
     String pubUrl = "";
     var res = await _dioServices?.dio?.get(S3Controller.GetPublicUrl+"?path="+privateUrl);
     if(res?.statusCode == 200){
       pubUrl = res?.data;
     }
     return pubUrl;
  }
}