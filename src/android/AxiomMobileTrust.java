package com.mollatech.cordova.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONObject;

import com.bluebricks.axiom.mobiletrust.app.helper.AxiomHelper;
import com.mollatech.axiom.mobiletrust.face.AxiomOTPResponse;

import android.content.Context;

public class AxiomMobileTrust extends CordovaPlugin {
	private static com.mollatech.mobiletrust.face.action.MobilityTrustVaultImpl mv = null;
	private static com.mollatech.mobiletrust.face.action.MobilityTrustKickStartImpl m = null;

	final String initialize = "initialize";
	final String load = "load";
	final String unLoad = "unLoad";
	final String confirm = "confirm";
	final String update = "update";
	final String ResetPin = "ResetPin";
	final String ChangePin = "ChangePin";
	final String ConfirmResetOrChangePin = "ConfirmResetOrChangePin";
	final String enableORDisableDebug = "enableORDisableDebug";
	final String SelfDestroy = "SelfDestroy";
	final String getLogs = "getLogs";
	final String checkstatus = "checkstatus";
	final String GetOTPPlus = "GetOTPPlus";
	final String GetSOTPPlus = "GetSOTPPlus";
	final String UnlockToken = "UnlockToken";

	JSONObject jsonResponse;
	String pin = null;
	String userid = null;
	String licensekey = null;
	String regcode = null;
	String timestamp = null;
	AxiomOTPResponse otpResponse;
	Context con;
	String result = "";

	public AxiomMobileTrust() {

	}

	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		Context context = cordova.getActivity().getApplicationContext();
		con = context;
		if (mv == null) {
			mv = new com.mollatech.mobiletrust.face.action.MobilityTrustVaultImpl();
			mv.SetGPSCoordinates("73.9287829", "18.5457378");
			mv.enableORDisableDebug(true);

		}
		if (m == null) {
			m = new com.mollatech.mobiletrust.face.action.MobilityTrustKickStartImpl();
			m.loadDelgate(context);
			m.enableORDisableDebug(true);
		}
	}

	public synchronized void initialize(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					regcode = args.getString(0);
					userid = args.getString(1);
					pin = args.getString(2);
					licensekey = args.getString(3);
					String strInitData = m.initialize(con, licensekey, userid, regcode, pin);
					jsonResponse = new JSONObject();
					jsonResponse.put("success", "true");
					jsonResponse.put("licensekey", licensekey);
					jsonResponse.put("initData", strInitData);
					callbackContext.success(jsonResponse);
				} catch (Exception e) {
					e.printStackTrace();
					callbackContext.error("Unable to Activate Token !!!");
				}

			};
		};

		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void load(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					userid = args.getString(0);
					pin = args.getString(1);
					licensekey = args.getString(2);
					int res = mv.load(con, licensekey, userid, pin);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void unload(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					userid = args.getString(0);
					int res = mv.unLoad(userid);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void confirm(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					// con = MainActivity.context;
					licensekey = args.getString(0);
					userid = args.getString(1);
					pin = args.getString(2);
					String toconfirm = args.getString(3);
					int res = m.confirm(con, licensekey, userid, pin, toconfirm);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}

			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void update(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					// con = MainActivity.context;
					userid = args.getString(0);
					String payload = args.getString(1);
					pin = args.getString(2);
					int res = m.Update(con, userid, payload, pin);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void resetPin(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					licensekey = args.getString(0);
					userid = args.getString(1);
					String doctype = args.getString(2);
					String uniqueId = args.getString(3);
					pin = args.getString(4);
					String tStamp = args.getString(4);
					String res = mv.ResetPin(con, licensekey, userid, doctype, uniqueId, pin, tStamp);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void changePin(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					pin = args.getString(0);
					String newpin = args.getString(1);
					String tStamp = args.getString(2);
					String res = mv.ChangePin(pin, newpin, tStamp);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void confirmResetOrChangePin(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					String toconfirm = args.getString(0);
					boolean res = mv.ConfirmResetOrChangePin(toconfirm);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void enableORDisableDebug(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					String bcheck = args.getString(0);
					boolean res = mv.enableORDisableDebug(Boolean.parseBoolean(bcheck));
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void selfDestroy(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					userid = args.getString(0);
					pin = args.getString(1);
					int res = m.selfDestroy(con, userid, pin);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void getLogs(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					String res = m.getLogs(con);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void checkStatus(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					userid = args.getString(0);
					int res = m.CheckStatus(con, userid);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void getOTPPlus(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					String timestamp = args.getString(0);
					otpResponse = mv.GetOTPPlus(timestamp);
					jsonResponse.put("otp", otpResponse.otp);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void getSOTPPlus(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				JSONObject jsonResponse = new JSONObject();
				try {
					timestamp = args.getString(0);
					String[] data = args.getString(1).split(",");
					otpResponse = mv.GetSOTPPlus(timestamp, data);
					jsonResponse.put("sotp", otpResponse.otp);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	public synchronized void unlockToken(final JSONArray args, final CallbackContext callbackContext) {
		Runnable runnable = new Runnable() {
			public void run() {
				try {
					userid = args.getString(0);
					licensekey = args.getString(1);
					pin = args.getString(2);
					String puk = args.getString(3);
					String res = mv.unlockToken(con, licensekey, userid, puk, pin);
					jsonResponse = new JSONObject();
					jsonResponse.put("Response", res);
					jsonResponse.put("success", "true");
					callbackContext.success(jsonResponse);
				} catch (Exception e1) {
					callbackContext.error(e1.getMessage());
				}
			};
		};
		this.cordova.getThreadPool().execute(runnable);
	}

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
		// this.callbackContext = callbackContext;
		AxiomHelper axiom = new AxiomHelper();
		// con = MainActivity.context;
		axiom.SetContext(con);
		// initialize
		if (initialize.equalsIgnoreCase(action)) {
			initialize(args, callbackContext);

			// load
		} else if (load.equalsIgnoreCase(action)) {
			load(args, callbackContext);

			// unLoad
		} else if (unLoad.equalsIgnoreCase(action)) {
			unload(args, callbackContext);

			// confirm
		} else if (confirm.equalsIgnoreCase(action)) {
			confirm(args, callbackContext);

			// update
		} else if (update.equalsIgnoreCase(action)) {
			update(args, callbackContext);

			// ResetPin
		} else if (ResetPin.equalsIgnoreCase(action)) {
			resetPin(args, callbackContext);

			// ChangePin
		} else if (ChangePin.equalsIgnoreCase(action)) {
			changePin(args, callbackContext);

			// ConfirmResetOrChangePin
		} else if (ConfirmResetOrChangePin.equalsIgnoreCase(action)) {
			confirmResetOrChangePin(args, callbackContext);

			// enableORDisableDebug
		} else if (enableORDisableDebug.equalsIgnoreCase(action)) {
			enableORDisableDebug(args, callbackContext);

			// SelfDestroy
		} else if (SelfDestroy.equalsIgnoreCase(action)) {
			selfDestroy(args, callbackContext);

			// getLogs
		} else if (getLogs.equalsIgnoreCase(action)) {
			getLogs(args, callbackContext);

			// checkstatus
		} else if (checkstatus.equalsIgnoreCase(action)) {
			checkStatus(args, callbackContext);

			// GetOTPPlus
		} else if (GetOTPPlus.equalsIgnoreCase(action)) {
			getOTPPlus(args, callbackContext);

			// GetSOTPPlus
		} else if (GetSOTPPlus.equalsIgnoreCase(action)) {
			getSOTPPlus(args, callbackContext);

			// UnlockToken
		} else if (UnlockToken.equalsIgnoreCase(action)) {
			unlockToken(args, callbackContext);

		}
		return true;
	}

}
