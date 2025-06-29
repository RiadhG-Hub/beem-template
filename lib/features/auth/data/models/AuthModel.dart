class AuthModel {
  final String? firstName;
  final String? lastName;
  final String? errorMessage;
  final int? status;
  final String? customActions;
  final String? annotationsTemplate;
  final String? inbox;
  final String? logo;
  final String? serviceType;
  final String? token;
  final String? signature;
  final String? signatureId;
  final String? transferData;
  final String? sections;
  final String? searchRecipients;
  final String? userDetails;
  final int? userId;
  final String? departmentName;
  final String? voiceNoteMaximumDuration;
  final String? visualTrackingURL;
  final String? userGctId;
  final String? structureId;
  final String? inboxesOrder;
  final String? inboxesType;
  final String? bamUrl;
  final String? usertype;
  final bool? showDelegation;
  final bool? showOffline;
  final bool? showReports;
  final bool? showBAM;
  final String? advancedSearchString;
  final String? advancedSearchInboxType;
  final String? departmentsList;
  final List<UserItem>? usersList;
  final String? signatures;
  final String? allDynamicImages;
  final String? captchaString;
  final String? digitalSignature;

  AuthModel({
    this.firstName,
    this.lastName,
    this.errorMessage,
    this.status,
    this.customActions,
    this.annotationsTemplate,
    this.inbox,
    this.logo,
    this.serviceType,
    this.token,
    this.signature,
    this.signatureId,
    this.transferData,
    this.sections,
    this.searchRecipients,
    this.userDetails,
    this.userId,
    this.departmentName,
    this.voiceNoteMaximumDuration,
    this.visualTrackingURL,
    this.userGctId,
    this.structureId,
    this.inboxesOrder,
    this.inboxesType,
    this.bamUrl,
    this.usertype,
    this.showDelegation,
    this.showOffline,
    this.showReports,
    this.showBAM,
    this.advancedSearchString,
    this.advancedSearchInboxType,
    this.departmentsList,
    this.usersList,
    this.signatures,
    this.allDynamicImages,
    this.captchaString,
    this.digitalSignature,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      errorMessage: json['ErrorMessage'],
      status: json['Status'],
      customActions: json['CustomActions'],
      annotationsTemplate: json['AnnotationsTemplate'],
      inbox: json['Inbox'],
      logo: json['Logo'],
      serviceType: json['ServiceType'],
      token: json['Token'],
      signature: json['Signature'],
      signatureId: json['SignatureId'],
      transferData: json['TransferData'],
      sections: json['Sections'],
      searchRecipients: json['SearchRecipients'],
      userDetails: json['UserDetails'],
      userId: json['UserId'],
      departmentName: json['DepartmentName'],
      voiceNoteMaximumDuration: json['VoiceNoteMaximumDuration'],
      visualTrackingURL: json['VisualTrackingURL'],
      userGctId: json['UserGctId'],
      structureId: json['StructureId'],
      inboxesOrder: json['InboxesOrder'],
      inboxesType: json['InboxesType'],
      bamUrl: json['BAMUrl'],
      usertype: json['usertype'],
      showDelegation: json['showDelegation'],
      showOffline: json['showOffline'],
      showReports: json['showReports'],
      showBAM: json['showBAM'],
      advancedSearchString: json['AdvancedSearchString'],
      advancedSearchInboxType: json['AdvancedSearchInboxType'],
      departmentsList: json['departmentsList'],
      usersList: (json['usersList'] as List?)
          ?.map((e) => UserItem.fromJson(e))
          .toList(),
      signatures: json['signatures'],
      allDynamicImages: json['AllDynamicImages'],
      captchaString: json['captchaString'],
      digitalSignature: json['DigitalSignature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'ErrorMessage': errorMessage,
      'Status': status,
      'CustomActions': customActions,
      'AnnotationsTemplate': annotationsTemplate,
      'Inbox': inbox,
      'Logo': logo,
      'ServiceType': serviceType,
      'Token': token,
      'Signature': signature,
      'SignatureId': signatureId,
      'TransferData': transferData,
      'Sections': sections,
      'SearchRecipients': searchRecipients,
      'UserDetails': userDetails,
      'UserId': userId,
      'DepartmentName': departmentName,
      'VoiceNoteMaximumDuration': voiceNoteMaximumDuration,
      'VisualTrackingURL': visualTrackingURL,
      'UserGctId': userGctId,
      'StructureId': structureId,
      'InboxesOrder': inboxesOrder,
      'InboxesType': inboxesType,
      'BAMUrl': bamUrl,
      'usertype': usertype,
      'showDelegation': showDelegation,
      'showOffline': showOffline,
      'showReports': showReports,
      'showBAM': showBAM,
      'AdvancedSearchString': advancedSearchString,
      'AdvancedSearchInboxType': advancedSearchInboxType,
      'departmentsList': departmentsList,
      'usersList': usersList?.map((e) => e.toJson()).toList(),
      'signatures': signatures,
      'AllDynamicImages': allDynamicImages,
      'captchaString': captchaString,
      'DigitalSignature': digitalSignature,
    };
  }
}

class UserItem {
  final String? id;
  final String? value;

  UserItem({this.id, this.value});

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}

enum UserType { minister, advisor, unknown }
