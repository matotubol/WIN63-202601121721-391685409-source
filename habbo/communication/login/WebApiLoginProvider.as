package com.sulake.habbo.communication.login
{
   import com.sulake.habbo.communication.class_2079;
   import com.sulake.habbo.communication.class_261;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.utils.CommunicationUtils;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class WebApiLoginProvider extends EventDispatcher implements class_261, ILoginProvider, class_260
   {
      
      public static const ERROR_TYPE_IO_ERROR:String = "ioError";
      
      public static const ERROR_CODE_MAINTENANCE:String = "maintenance";
      
      private static const AUTO_RECONNECT:Boolean = false;
      
      private static const POCKET_MODE_LOGIN_AND_REGISTER:int = 1;
      
      private static const const_528:int = 2;
      
      private var _communication:class_57;
      
      private var var_1273:String;
      
      private var var_88:ILoginViewer;
      
      private var _pendingLoginError:Object;
      
      private var _autoLogin:Boolean = false;
      
      private var _localizationLoaded:Boolean;
      
      private var var_2239:Boolean;
      
      private var var_3638:Boolean;
      
      private var var_2627:int = 1;
      
      private var _name:String;
      
      private var var_2861:String;
      
      private var var_5236:int;
      
      private var var_5259:String;
      
      private var _ssoToken:String;
      
      private var var_70:class_2079;
      
      private var var_1917:class_262;
      
      public function WebApiLoginProvider(param1:ILoginViewer)
      {
         super();
         var_88 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function init(param1:class_57) : void
      {
         _communication = param1;
         var _loc2_:String = getProperty("web.api");
         class_21.log("[WebApiLoginProvider] Init with: " + _loc2_);
         if(_loc2_ != null)
         {
            _communication.createHabboWebApiSession(this,_loc2_);
         }
         var_70 = createHabboWebApiSession();
         initHabboWebApiSession();
      }
      
      public function loginWithCredentials(param1:String, param2:String, param3:int = 0) : void
      {
         _name = param1;
         var_2861 = param2;
         var_5236 = param3;
         if(var_70)
         {
            var_70.login(param1,param2);
         }
         else
         {
            class_21.log("[WebApiLoginProvider] Login not available");
         }
      }
      
      public function loginWithCredentialsWeb(param1:String) : void
      {
         var_5259 = param1;
         if(var_70)
         {
            var_70.selectAvatar(param1);
         }
         else
         {
            class_21.log("[WebApiLoginProvider] Login not available");
         }
      }
      
      private function createHabboWebApiSession() : class_2079
      {
         var _loc2_:class_2079 = _communication.getHabboWebApiSession();
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         var _loc1_:String = getProperty("web.api");
         if(_loc1_ == "")
         {
            _loc1_ = getProperty("url.prefix");
            _loc1_ = _loc1_.replace("http:","https:");
         }
         return _communication.createHabboWebApiSession(this,_loc1_);
      }
      
      private function initHabboWebApiSession() : void
      {
         if(var_70)
         {
            var_70.hello();
            return;
         }
         throw new Error("Tried to init null IHabboWebApiSession");
      }
      
      public function habboWebApiError(param1:String, param2:int, param3:String, param4:Object, param5:Boolean = false) : void
      {
         var _loc8_:Boolean = false;
         class_21.log("[WebApiLoginProvider] Api Error: id: " + param1 + " type: " + param3 + " captcha: " + param5);
         if((param4 && param4.error ? param4.error : "") == "maintenance")
         {
         }
         var _loc9_:Boolean = false;
         if(param3 == "ioError")
         {
            _loc9_ = true;
         }
         var _loc6_:class_2079 = _communication.getHabboWebApiSession();
         switch(param1)
         {
            case "/api/ssotoken":
               if(_autoLogin)
               {
                  _loc9_ = true;
                  _loc6_.login(_name,var_2861);
               }
            case "/api/public/info/hello":
               var_88.showLoginScreen();
               break;
            case "/api/public/registration/new":
               var_88.showRegistrationError(param4);
               break;
            case "/api/ssotoken":
               class_21.log("[WebApiLoginProvider] There was an error getting the SSO-token (is this an employee account?)...");
               var_88.showInvalidLoginError(param4);
               break;
            case "/api/user/avatars":
               class_21.log("[WebApiLoginProvider] There was an error getting the Avatars");
               var_88.showInvalidLoginError(param4);
               break;
            case "/api/newuser/name/check":
            case "/api/newuser/name/select":
               class_21.log("[WebApiLoginProvider] There was an error checking name");
               var_88.nameCheckResponse(param4,param1 == "/api/newuser/name/check");
               break;
            case "/api/public/authentication/login":
            case "/api/public/authentication/facebook":
            case "/api/force/tos-accept":
               class_21.log("[WebApiLoginProvider] There was an error authorizing connection...");
               if(param4 != null && (param4.message != null || param4.error != null || param4.errors != null))
               {
                  if(param5)
                  {
                     _loc8_ = param4.captcha == true && param4.message == "invalid-captcha";
                     if(!_loc8_)
                     {
                        _pendingLoginError = param4;
                     }
                     showCaptchaView();
                     break;
                  }
                  var_88.showInvalidLoginError(param4);
                  break;
               }
               if(param5)
               {
                  showCaptchaView();
                  break;
               }
               var_88.showInvalidLoginError(null);
               break;
            case "/api/user/avatars/select":
               class_21.log("[WebApiLoginProvider] There was an error selecting avatar");
               if(_loc6_)
               {
                  var_88.showAccountError(param4);
                  var_88.showLoadingScreen();
                  _loc6_.avatars();
                  break;
               }
               var_88.showInvalidLoginError(param4);
               break;
            case "/api/newuser/room/select":
               class_21.log("[WebApiLoginProvider] There was an error selecting home room.");
               break;
            case "/api/user/look/save":
               var_88.saveLooksError(param4);
               break;
            default:
               class_21.log("[WebApiLoginProvider] Did not process Habbo API message: " + param1);
         }
         if(!_loc9_)
         {
            _autoLogin = false;
         }
      }
      
      public function onUserList(param1:Vector.<AvatarData>) : void
      {
         var _loc2_:String = null;
         if(_autoLogin)
         {
            _loc2_ = CommunicationUtils.readSOLString("useruniqueid");
            if(!userExists(param1,_loc2_))
            {
               var_88.populateCharacterList(param1);
            }
         }
         else
         {
            var_88.populateCharacterList(param1);
         }
      }
      
      public function habboWebApiResponse(param1:String, param2:Object) : void
      {
         var _loc8_:Array = null;
         class_21.log("[WebApiLoginProvider] Got Habbo Web Api Response: " + param1,param2);
         var _loc6_:class_2079 = _communication.getHabboWebApiSession();
         if(_loc6_ == null)
         {
            return;
         }
         if(param2 != null && param2.force != null && param2.force is Array)
         {
            _loc8_ = param2.force as Array;
            if(_loc8_.indexOf("TOS") > -1)
            {
               var_88.showTOS();
               return;
            }
            if(_loc8_.indexOf("EMAIL") > -1 || _loc8_.indexOf("PASSWORD") > -1)
            {
               var_88.showInvalidLoginError({"errors":["account_issue"]});
               return;
            }
         }
         switch(param1)
         {
            case "/api/public/info/hello":
               if(var_2627 == 1)
               {
               }
               if(_autoLogin)
               {
                  _loc6_.ssoToken();
                  break;
               }
               var_88.environmentReady();
               break;
            case "/api/user/avatars/select":
               if(var_2627 != 2)
               {
                  _loc6_.ssoToken();
               }
               break;
            case "/api/public/authentication/login":
            case "/api/public/authentication/facebook":
            case "/api/force/tos-accept":
               var _loc5_:String = param1 == "/api/public/authentication/login" ? "habbo" : "facebook";
               CommunicationUtils.writeSOLProperty("loginmethod",null);
               fetchAvatars();
               break;
            case "/api/user/avatars":
               if(var_2627 != 2)
               {
                  var _loc7_:Vector.<AvatarData> = new Vector.<AvatarData>(0);
                  for each(var _loc3_ in param2)
                  {
                     undefined.push(new AvatarData(_loc3_));
                  }
                  if(undefined.length == 1)
                  {
                     CommunicationUtils.writeSOLProperty("useruniqueid",undefined[0].uniqueId);
                     _loc6_.selectAvatar(undefined[0].uniqueId);
                     break;
                  }
                  if(!_autoLogin)
                  {
                     var_88.populateCharacterList(undefined);
                  }
               }
               break;
            case "/api/ssotoken":
               _ssoToken = param2["ssoToken"];
               var_2627 = 2;
               dispatchEvent(new SsoTokenAvailableEvent("SSO_TOKEN_AVAILABLE",_ssoToken));
               break;
            case "/api/public/registration/new":
               if(param2 != null)
               {
                  var _loc4_:int = parseInt(param2.id);
                  CommunicationUtils.writeSOLProperty("userid",(0).toString());
               }
               var_88.showSelectAvatar(param2);
               break;
            case "/api/public/lists/hotlooks":
               var_88.showPromoHabbos(param2 as XML);
               break;
            case "/api/newuser/name/select":
            case "/api/newuser/name/check":
               var_88.nameCheckResponse(param2,param1 == "/api/newuser/name/check");
               break;
            case "/api/user/look/save":
               var_88.showSelectRoom();
               break;
            case "/api/newuser/room/select":
               CommunicationUtils.writeSOLProperty("loginmethod","habbo");
               fetchAvatars();
         }
      }
      
      public function habboWebApiRawResponse(param1:String, param2:Object) : void
      {
      }
      
      public function closeCaptcha() : void
      {
         removeCaptchaView();
      }
      
      private function showCaptchaView() : void
      {
         var_1917 = var_88.createCaptchaView();
         if(var_1917 == null)
         {
            var_88.showCaptchaError();
         }
      }
      
      public function handleCaptchaError() : void
      {
         removeCaptchaView();
         var_88.showCaptchaError();
      }
      
      public function handleCaptchaResult(param1:String) : void
      {
         removeCaptchaView();
         var_88.captchaReady();
         if(_pendingLoginError)
         {
            var_88.showInvalidLoginError(_pendingLoginError);
            _pendingLoginError = null;
         }
         if(param1 == null || var_70 == null)
         {
            var_88.showCaptchaError();
            return;
         }
         var _loc2_:Boolean = var_70.setCaptchaToken(param1);
      }
      
      private function removeCaptchaView() : void
      {
         if(var_1917 != null)
         {
            var_1917.dispose();
            var_1917 = null;
         }
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return var_88.getProperty(param1,param2);
      }
      
      private function userExists(param1:Vector.<AvatarData>, param2:String) : Boolean
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.uniqueId == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      private function fetchAvatars() : void
      {
         var _loc1_:String = null;
         if(var_70 == null)
         {
            return;
         }
         if(_autoLogin)
         {
            _loc1_ = CommunicationUtils.readSOLString("useruniqueid");
            if(_loc1_)
            {
               var_70.selectAvatar(_loc1_);
            }
            else
            {
               var_70.avatars();
            }
         }
         else if(var_2627 == 1)
         {
            var_70.avatars();
         }
      }
      
      public function selectAvatar(param1:int) : void
      {
      }
      
      public function selectAvatarUniqueid(param1:String) : void
      {
         if(var_70 == null)
         {
            return;
         }
         var_70.selectAvatar(param1);
      }
   }
}

