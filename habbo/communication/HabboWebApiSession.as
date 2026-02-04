package com.sulake.habbo.communication
{
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.util.class_50;
   import com.sulake.core.runtime.class_22;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.class_14;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class HabboWebApiSession implements class_2079, class_2080, class_22
   {
      
      private var SHARED_SECRET:String = "CnurvLf7UP";
      
      private var var_436:Dictionary;
      
      private var var_4591:XMLList;
      
      private var _server:String;
      
      private var _captchaToken:String;
      
      private var _listeners:Vector.<class_261>;
      
      private var var_5378:Boolean = false;
      
      private var var_1134:Boolean;
      
      private var var_3533:String;
      
      private var _deviceToken:String;
      
      private var var_3159:WebApiRequest;
      
      private var var_5030:URLVariables;
      
      private var var_4891:Array;
      
      private var var_2500:String;
      
      public function HabboWebApiSession(param1:String)
      {
         super();
         var _loc4_:String = CommunicationUtils.readSOLString("machineid",CommunicationUtils.generateRandomHexString(32));
         var_3533 = generateDeviceId(_loc4_);
         _server = param1;
         _listeners = new Vector.<class_261>(0);
         var_4591 = describeType(this)..method;
         var _loc9_:XML = describeType(class_2079);
         class_21.log("[HabboWebApiSession] Start searching for Metadata");
         var_436 = new Dictionary();
         var _loc2_:String = "";
         var _loc5_:int = 0;
         for each(var _loc8_ in _loc9_.factory.method)
         {
            var _loc7_:String = _loc8_.@name;
            for each(var _loc3_ in _loc8_.metadata)
            {
               if(_loc3_.@name == "HabboWebApiRoute")
               {
                  var _loc10_:String = _loc3_.arg.(@key == "uri")[0].@value;
                  var _loc6_:String = _loc3_.arg.(@key == "method")[0].@value;
                  throw new Error("Web Api Route Metdata missing for method (both uri and requestType are required): " + null);
               }
            }
         }
         if(_loc5_ == 0)
         {
            class_21.log("[HabboWebApiSession] Could not fetch META information correctly, make sure the build-params keep the information!");
         }
      }
      
      private function generateDeviceId(param1:String) : String
      {
         var _loc2_:SHA1 = new SHA1();
         var _loc4_:ByteArray = class_50.toArray(class_50.fromString(SHARED_SECRET + param1));
         var _loc5_:ByteArray = _loc2_.hash(_loc4_);
         var _loc3_:String = class_50.fromArray(_loc5_);
         return param1 + ":" + _loc3_;
      }
      
      private function getFunctionName(param1:Function) : String
      {
         for each(var _loc2_ in var_4591)
         {
            if(this[_loc2_.@name] == param1)
            {
               return _loc2_.@name;
            }
         }
         return null;
      }
      
      private function getURL(param1:String) : String
      {
         return _server + param1;
      }
      
      private function executeRequest(param1:String, param2:URLVariables = null, param3:Array = null) : void
      {
         if(param1 != null)
         {
            var _loc5_:WebApiRequest;
            var_3159 = _loc5_ = var_436[param1];
            var_5030 = param2;
            var_4891 = param3;
         }
         else
         {
            class_21.log("Could not execute request for null method...");
         }
      }
      
      public function setCaptchaToken(param1:String) : Boolean
      {
         _captchaToken = param1;
         if(var_3159 && var_2500 && var_2500 == var_3159.uri)
         {
            var _loc2_:String = getMethodForRequest(var_3159);
         }
         return false;
      }
      
      public function get captchaToken() : String
      {
         return _captchaToken;
      }
      
      private function getMethodForRequest(param1:WebApiRequest) : String
      {
         var _loc2_:WebApiRequest = null;
         for(var _loc3_ in var_436)
         {
            _loc2_ = var_436[_loc3_];
            if(_loc2_ && _loc2_.uri == param1.uri)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function addHeaders(param1:URLRequest) : void
      {
         param1.requestHeaders.push(new URLRequestHeader("X-Habbo-Device-ID",var_3533));
         param1.requestHeaders.push(new URLRequestHeader("x-habbo-api-deviceid",var_3533));
         param1.requestHeaders.push(new URLRequestHeader("X-Habbo-Device-Type",class_14.platformString()));
      }
      
      public function apiResponse(param1:String, param2:Object) : void
      {
         class_21.log("[HabboWebApiSession] Got response for Web Api: " + param1);
         if(_listeners != null)
         {
            for each(var _loc3_ in _listeners)
            {
               if(!_loc3_.disposed)
               {
                  _loc3_.habboWebApiResponse(param1,param2);
               }
            }
         }
      }
      
      public function apiRawResponse(param1:String, param2:Object) : void
      {
         class_21.log("[HabboWebApiSession] Got response for Web Api Raw: " + param1);
         if(_listeners != null)
         {
            for each(var _loc3_ in _listeners)
            {
               if(!_loc3_.disposed)
               {
                  _loc3_.habboWebApiRawResponse(param1,param2);
               }
            }
         }
      }
      
      public function apiError(param1:String, param2:int, param3:String, param4:Object, param5:Boolean = false) : void
      {
         class_21.log("[HabboWebApiSession] Got error for Web Api: " + param1,param2,param3,param4);
         var_2500 = null;
         if(param4 != null && param4 is String)
         {
            param4 = {"error":param4};
         }
         if(param4 != null && !(param4 is String))
         {
            if(param4.error == null)
            {
               var _loc8_:Array = param4.errors;
               var _loc7_:String = _loc8_ && null.length > 0 ? null[0] : "";
               if(_loc7_ == "" && param4.message != null)
               {
                  _loc7_ = param4.message;
               }
            }
            else
            {
               _loc7_ = param4.error as String;
            }
         }
         else
         {
            _loc7_ = param2.toString();
         }
         class_21.log("[HabboWebApiSession] Error code: " + null);
         switch(null)
         {
            case "invalid-captcha":
            case "registration.captcha_is_empty":
            case "registration.invalid_captcha":
               var_2500 = param1;
         }
         if(_listeners != null)
         {
            for each(var _loc6_ in _listeners)
            {
               if(!_loc6_.disposed)
               {
                  _loc6_.habboWebApiError(param1,param2,param3,param4,param5);
               }
            }
         }
      }
      
      public function dispose() : void
      {
         _listeners = null;
         _server = "";
         var_1134 = true;
         for(var _loc2_ in var_436)
         {
            var _loc1_:WebApiRequest = var_436[_loc2_];
            null.dispose();
         }
         var_436 = new Dictionary();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function addListener(param1:class_261) : Boolean
      {
         if(_listeners && _listeners.indexOf(param1) == -1)
         {
            _listeners.push(param1);
            return true;
         }
         return false;
      }
      
      public function removeListener(param1:class_261) : void
      {
         if(_listeners)
         {
            var _loc2_:int = int(_listeners.indexOf(param1));
            _listeners.splice(0,1);
         }
      }
      
      public function emailChange(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.newEmail = param1;
         executeRequest(getFunctionName(emailChange),_loc2_);
      }
      
      public function passwordChange(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.newPassword = param1;
         executeRequest(getFunctionName(passwordChange),_loc2_);
      }
      
      public function tosAccept() : void
      {
         executeRequest(getFunctionName(tosAccept));
      }
      
      public function captcha() : void
      {
         executeRequest(getFunctionName(captcha));
      }
      
      public function achievements() : void
      {
         executeRequest(getFunctionName(achievements));
      }
      
      public function achievementsForId(param1:int) : void
      {
         executeRequest(getFunctionName(achievementsForId),null,["id",param1]);
      }
      
      public function time() : void
      {
         executeRequest(getFunctionName(time));
      }
      
      public function activate(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.token = param1;
         executeRequest(getFunctionName(activate),_loc2_);
      }
      
      public function login(param1:String, param2:String) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.email = param1;
         _loc3_.password = param2;
         executeRequest(getFunctionName(login),_loc3_);
      }
      
      public function facebook(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.accessToken = param1;
         executeRequest(getFunctionName(facebook),_loc2_);
      }
      
      public function rpx(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.token = param1;
         executeRequest(getFunctionName(rpx),_loc2_);
      }
      
      public function logout() : void
      {
         executeRequest(getFunctionName(logout));
      }
      
      public function authenticateUser() : void
      {
         executeRequest(getFunctionName(authenticateUser));
      }
      
      public function forgotPassword(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.email = param1;
         executeRequest(getFunctionName(forgotPassword),_loc2_);
      }
      
      public function changePassword(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:URLVariables = new URLVariables();
         _loc5_.token = param1;
         _loc5_.password = param2;
         _loc5_.answer1 = param3;
         _loc5_.answer2 = param4;
         executeRequest(getFunctionName(changePassword),_loc5_);
      }
      
      public function groups(param1:int) : void
      {
         executeRequest(getFunctionName(groups),null,["id",param1]);
      }
      
      public function members(param1:int) : void
      {
         executeRequest(getFunctionName(members),null,["id",param1]);
      }
      
      public function hello() : void
      {
         executeRequest(getFunctionName(hello));
      }
      
      public function register(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Boolean, param7:String) : void
      {
         _captchaToken = param7;
         var _loc8_:URLVariables = new URLVariables();
         _loc8_.email = param1;
         _loc8_.password = param2;
         _loc8_.passwordRepeated = param2;
         _loc8_.birthdate = {
            "day":param3,
            "month":param4,
            "year":param5
         };
         _loc8_.termsOfServiceAccepted = param6;
         executeRequest(getFunctionName(register),_loc8_);
      }
      
      public function popularRooms() : void
      {
         executeRequest(getFunctionName(popularRooms));
      }
      
      public function room(param1:int) : void
      {
         executeRequest(getFunctionName(room),null,["id",param1]);
      }
      
      public function hotlooks() : void
      {
         executeRequest(getFunctionName(hotlooks));
      }
      
      public function logCrash(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.message = param1;
         executeRequest(getFunctionName(logCrash),_loc2_);
      }
      
      public function logError(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.message = param1;
         executeRequest(getFunctionName(logError),_loc2_);
      }
      
      public function logLoginStep(param1:String, param2:String) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.step = param1;
         executeRequest(getFunctionName(logLoginStep),_loc3_);
      }
      
      public function clientUrl() : void
      {
         executeRequest(getFunctionName(clientUrl));
      }
      
      public function nameCheck(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.name = param1;
         executeRequest(getFunctionName(nameCheck),_loc2_);
      }
      
      public function selectUser(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.name = param1;
         executeRequest(getFunctionName(selectUser),_loc2_);
      }
      
      public function selectRoom(param1:int) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.roomIndex = param1;
         executeRequest(getFunctionName(selectRoom),_loc2_);
      }
      
      public function safetyLockStatus() : void
      {
         executeRequest(getFunctionName(safetyLockStatus));
      }
      
      public function safetyLockDisable() : void
      {
         executeRequest(getFunctionName(safetyLockDisable));
      }
      
      public function resetTrustedLogins() : void
      {
         executeRequest(getFunctionName(resetTrustedLogins));
      }
      
      public function safetyLockSave(param1:String, param2:int, param3:String, param4:int, param5:String) : void
      {
         var _loc6_:URLVariables = new URLVariables();
         _loc6_.password = param1;
         _loc6_.questionId1 = param2;
         _loc6_.answer1 = param3;
         _loc6_.questionId2 = param4;
         _loc6_.answer2 = param5;
         executeRequest(getFunctionName(safetyLockSave),_loc6_);
      }
      
      public function safetyLockQuestions() : void
      {
         executeRequest(getFunctionName(safetyLockQuestions));
      }
      
      public function safetyLockUnlock(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc4_:URLVariables = new URLVariables();
         _loc4_.answer1 = param1;
         _loc4_.answer2 = param2;
         _loc4_.trustDevice = param3;
         executeRequest(getFunctionName(safetyLockUnlock),_loc4_);
      }
      
      public function commonFriends(param1:int) : void
      {
         executeRequest(getFunctionName(commonFriends),null,["id",param1]);
      }
      
      public function preferences() : void
      {
         executeRequest(getFunctionName(preferences));
      }
      
      public function self() : void
      {
         executeRequest(getFunctionName(self));
      }
      
      public function ping() : void
      {
         executeRequest(getFunctionName(ping));
      }
      
      public function saveUser() : void
      {
         executeRequest(getFunctionName(saveUser));
      }
      
      public function saveVisibility(param1:Boolean) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.visibility = param1;
         executeRequest(getFunctionName(saveVisibility),_loc2_);
      }
      
      public function campaignMessages() : void
      {
         executeRequest(getFunctionName(campaignMessages));
      }
      
      public function campaignMessagesAll() : void
      {
         executeRequest(getFunctionName(campaignMessagesAll));
      }
      
      public function campaignMessagesSeen() : void
      {
         executeRequest(getFunctionName(campaignMessagesSeen));
      }
      
      public function discussions() : void
      {
         executeRequest(getFunctionName(discussions));
      }
      
      public function creditBalance() : void
      {
         executeRequest(getFunctionName(creditBalance));
      }
      
      public function friendRequestsSent() : void
      {
         executeRequest(getFunctionName(friendRequestsSent));
      }
      
      public function friendRequestsReceived() : void
      {
         executeRequest(getFunctionName(friendRequestsReceived));
      }
      
      public function saveLooks(param1:String, param2:String) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.figure = param1;
         _loc3_.gender = param2;
         executeRequest(getFunctionName(saveLooks),_loc3_);
      }
      
      public function avatars() : void
      {
         executeRequest(getFunctionName(avatars));
      }
      
      public function selectAvatar(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.uniqueId = param1;
         executeRequest(getFunctionName(selectAvatar),_loc2_);
      }
      
      public function changeEmail(param1:String, param2:String) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.newEmail = param1;
         _loc3_.currentPassword = param2;
         executeRequest(getFunctionName(changeEmail),_loc3_);
      }
      
      public function createAvatar(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.name = param1;
         executeRequest(getFunctionName(createAvatar),_loc2_);
      }
      
      public function profile() : void
      {
         executeRequest(getFunctionName(profile));
      }
      
      public function ssoToken() : void
      {
         executeRequest(getFunctionName(ssoToken));
      }
      
      public function validateItunesIAP(param1:String, param2:String, param3:int, param4:String) : void
      {
         var _loc5_:URLVariables = new URLVariables();
         _loc5_.transactionId = param1;
         _loc5_.receipt = param2;
         _loc5_.centPrice = param3;
         _loc5_.priceLocale = param4;
         executeRequest(getFunctionName(validateItunesIAP),_loc5_);
      }
      
      public function validatePlaystoreIAP(param1:String, param2:String, param3:int, param4:String, param5:String) : void
      {
         var _loc6_:URLVariables = new URLVariables();
         _loc6_.transactionId = param1;
         _loc6_.receipt = param2;
         _loc6_.centPrice = param3;
         _loc6_.priceLocale = param4;
         _loc6_.signature = param5;
         executeRequest(getFunctionName(validatePlaystoreIAP),_loc6_);
      }
      
      public function setDeviceToken(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.device_token = param1;
         _deviceToken = param1;
         executeRequest(getFunctionName(setDeviceToken),_loc2_);
      }
      
      public function getDeviceToken() : String
      {
         return _deviceToken;
      }
   }
}

