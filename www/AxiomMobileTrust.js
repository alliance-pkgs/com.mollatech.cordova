var safeExports = {};

// 1. initialize()
safeExports.initialize = function(regcode,userid,pin,license,successCallback, failureCallback) {
	pin = pin.toString();
    cordova.exec(successCallback, failureCallback, "AxiomMobileTrust", "initialize", [regcode,userid, pin,license]);
}

// load()
safeExports.load = function(userid,pin,licensekey,successCallback, failureCallback) {
	pin = pin.toString();
 cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'load', [userid,pin,licensekey]);
}

// unLoad()
safeExports.unLoad = function(userid,successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'unLoad', [userid]);
}

// confirm()
safeExports.confirm = function(userid,pin,toconfirm,licensekey,successCallback, failureCallback) {
	pin = pin.toString();
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'confirm', [licensekey,userid,pin,toconfirm]);
}

// update()
safeExports.update = function(userid,payload,pin,successCallback, failureCallback) {
	pin = pin.toString();
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'update', [userid,payload,pin]);
}

// ResetPin()
safeExports.ResetPin = function(userid,doctype,uniqueId,newpin,tStamp,licensekey,successCallback, failureCallback) {
	newpin = newpin.toString();
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'ResetPin', [licensekey,userid,doctype, uniqueId, newpin, tStamp]);
}

//ChangePin
safeExports.ChangePin = function(pin,newpin,tStamp,successCallback, failureCallback) {
	pin = pin.toString();
	newpin = newpin.toString();
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'ChangePin', [pin,newpin,tStamp]);
}

//ConfirmResetOrChangePin
safeExports.ConfirmResetOrChangePin = function(toconfirm,successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'ConfirmResetOrChangePin', [toconfirm]);
}

// enableORDisableDebug()
safeExports.enableORDisableDebug = function(bcheck,successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'enableORDisableDebug', [bcheck]);
}

// SelfDestroy()
safeExports.SelfDestroy = function(userid,pin,successCallback, failureCallback) {
	pin = pin.toString();
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'SelfDestroy', [userid, pin]);
}

// getLogs()
safeExports.getLogs = function(successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'getLogs', []);
}

// checkstatus()
safeExports.checkstatus = function(userid,successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'checkstatus', [userid]);
}

// GetOTPPlus()
safeExports.GetOTPPlus = function(timestamp,successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'GetOTPPlus', [timestamp]);
}

// GetSOTPPlus()
safeExports.GetSOTPPlus = function(timestamp,data,successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'GetSOTPPlus', [timestamp,data]);
}

// UnlockToken
safeExports.UnlockToken = function(userid,pin,puk,licensekey,successCallback, failureCallback) {
	pin = pin.toString()
    cordova.exec(successCallback, failureCallback, 'AxiomMobileTrust', 'UnlockToken', [userid,licensekey,pin,puk]);
}
module.exports = safeExports;