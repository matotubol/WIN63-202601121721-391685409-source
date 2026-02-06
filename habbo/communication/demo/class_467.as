package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.runtime.events.HotelViewEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.communication.class_2079;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.login.AvatarData;
   import com.sulake.habbo.communication.login.ILoginProvider;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.*;
   import flash.display.Stage;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.system.Capabilities;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.*;
   import com.sulake.habbo.communication.messages.incoming.handshake.*;
   
   [SecureSWF(rename="true")]
   public class class_467 extends class_17
   {
      
      public static const ERROR_TYPE_IO_ERROR:String = "ioError";
      
      public static const ERROR_CODE_MAINTENANCE:String = "maintenance";
      
      private static const AUTO_RECONNECT:Boolean = false;
      
      private var var_88:class_2127;
      
      private var _logoutInProgress:Boolean;
      
      private var var_4879:String;
      
      private var var_1692:class_1762;
      
      private var _communication:class_57;
      
      private var _localization:class_27;
      
      private var _windowManager:class_38;
      
      private var var_538:String;
      
      private var var_2877:String;
      
      private var _loginName:String;
      
      private var var_2861:String;
      
      private var var_1220:ILoginProvider;
      
      private var var_2239:Boolean;
      
      private var _autoLogin:Boolean;
      
      private var var_3638:Boolean;
      
      private var var_2090:ErrorPopupCtrl;
      
      public function class_467(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         param1.events.addEventListener("unload",unloading);
         var_2090 = new ErrorPopupCtrl(param1,0,param3);
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function set ssoTicket(param1:String) : void
      {
         var_538 = param1;
      }
      
      public function set flashClientUrl(param1:String) : void
      {
         var_2877 = param1;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         },!isRoomViewerMode),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         },true,[{
            "type":"complete",
            "callback":onLocalizationsComplete
         },{
            "type":"LOCALIZATION_EVENT_LOCALIZATION_FAILED",
            "callback":onLocalizationFailed
         }])]);
      }
      
      override protected function initComponent() : void
      {
         class_23.instance.events.addEventListener("COMPONENT_EVENT_ERROR",onCoreError);
         var _loc1_:Stage = context.displayObjectContainer.stage;
         if(_loc1_ != null)
         {
            _loc1_.dispatchEvent(new HotelViewEvent("HOTEL_VIEW_READY"));
         }
         var_2239 = false;
         if(var_1692)
         {
            var_1692.dispose();
            if(_communication)
            {
               _communication.renewSocket();
            }
         }
         var_1692 = new class_1762(this,_communication);
         context.events.addEventListener("HHVE_ERROR",onHotelViewError);
         prepareProperties();
         HabboWebTools.baseUrl = getProperty("url.prefix");
         if(_autoLogin)
         {
            initWithStoredCredentials();
         }
         else if(var_538)
         {
            initWithSSO(var_538);
         }
         else
         {
            initWithLoginView();
         }
      }
      
      override public function dispose() : void
      {
         if(class_23.instance.events)
         {
            class_23.instance.events.removeEventListener("COMPONENT_EVENT_ERROR",onCoreError);
         }
         if(var_88)
         {
            var_88.dispose();
            var_88 = null;
         }
         if(var_1692)
         {
            var_1692.dispose();
            var_1692 = null;
         }
         _localization = null;
         _communication = null;
         if(var_2090)
         {
            var_2090.dispose();
            var_2090 = null;
         }
      }
      
      public function initGameSocket() : void
      {
         dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_INIT");
         if(var_538 != null)
         {
            _communication.mode = 0;
         }
         else
         {
            _communication.mode = 0;
         }
         _communication.initConnection("habbo");
      }
      
      private function prepareProperties() : void
      {
         _localization.loadDefaultEmbedLocalizations("en");
         _loginName = CommunicationUtils.readSOLString("login");
         var_2861 = CommunicationUtils.restorePassword();
         var _loc2_:String = CommunicationUtils.readSOLString("environment");
         var _loc3_:String = CommunicationUtils.readSOLString("loginmethod","habbo");
         var _loc6_:Boolean = CommunicationUtils.readSOLBoolean("autologin");
         var _loc5_:Boolean = CommunicationUtils.forcedAutoLoginEnabled;
         CommunicationUtils.forcedAutoLoginEnabled = false;
         var _loc4_:Array = getProperty("live.environment.list").split("/");
         if(_loc4_.indexOf(_loc2_) == -1)
         {
            class_21.log("Missing environment, require hotel selection! " + _loc2_);
            _loc2_ = null;
            CommunicationUtils.writeSOLProperty("environment",null);
         }
         if(_loc2_ != null)
         {
            initEnvironment(_loc2_);
         }
         var_538 = getProperty("sso.token");
         var_2877 = getProperty("flash.client.url");
         var_4879 = getProperty("external.variables.txt");
         var _loc1_:Boolean = getBoolean("use.sso");
      }
      
      private function initWithStoredCredentials() : void
      {
         _communication.mode = 0;
         var_88.showLoadingScreen();
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         initEnvironment(_loc1_);
      }
      
      private function initWithSSO(param1:String) : void
      {
         var_538 = param1;
         _communication.mode = 0;
         initGameSocket();
      }
      
      private function initWithLoginView() : void
      {
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         if(_loc1_ == null || _loc1_ == "")
         {
         }
         if(_windowManager != null && !isRoomViewerMode)
         {
            class_23.crash("Login without an SSO ticket is not supported",29);
         }
         if(_loc1_ && _loc1_ == "")
         {
            var_1220.init(_communication);
         }
      }
      
      private function onInitLogin(param1:Event) : void
      {
         var _loc2_:class_2079 = null;
         if(var_88.useWebApi)
         {
            _loc2_ = _communication.getHabboWebApiSession();
            _loc2_.login(var_88.name,var_88.password);
         }
         else
         {
            initGameSocket();
         }
      }
      
      private function onAvatarSelected(param1:Event) : void
      {
         var _loc2_:class_2079 = null;
         if(var_88.useWebApi)
         {
            _loc2_ = _communication.getHabboWebApiSession();
            _loc2_.selectAvatar(var_88.selectedAccount.uniqueId);
         }
         else
         {
            sendTryLoginDevelopmentOnly(var_88.name,var_88.password,var_88.avatarId);
         }
      }
      
      private function onEnvironmentSelected(param1:Event) : void
      {
         initEnvironment(var_88.selectedEnvironment);
      }
      
      private function initEnvironment(param1:String) : void
      {
         setProperty("environment.id",param1);
         CommunicationUtils.writeSOLProperty("environment",param1);
         updateEnvironmentVariables(param1);
         _communication.updateHostParameters();
         _communication.resetHabboWebApiSession();
         _localization.loadDefaultEmbedLocalizations(param1);
         if(var_88 != null)
         {
            if(var_88.useWebApi)
            {
               var_1220.init(_communication);
            }
            else
            {
               var_88.environmentReady();
            }
         }
      }
      
      private function onConfigurationLoaded(param1:Event) : void
      {
         class_21.log("[HabboCommunicationDemo] Configuration Loaded!");
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         var _loc2_:DataEvent = param1 as DataEvent;
         class_21.log("[HabboCommunicationDemo] Configuration Error!");
         if(_loc2_ && _loc2_.data == "503")
         {
         }
      }
      
      private function onLocalizationsComplete(param1:Event) : void
      {
      }
      
      private function onLocalizationFailed(param1:Event) : void
      {
      }
      
      public function setSSOTicket(param1:String) : void
      {
         if(param1 && !var_538)
         {
            var_538 = param1;
            initGameSocket();
         }
      }
      
      public function sendTryLoginDevelopmentOnly(param1:String, param2:String, param3:int = 0) : void
      {
         var _loc5_:IConnection = _communication.connection;
         if(!_loc5_)
         {
            _communication.initConnection("habbo");
            _loc5_ = _communication.connection;
         }
         var _loc4_:class_1840 = new class_1840(param1,param2,param3);
         _loc5_.send(_loc4_);
      }
      
      public function sendConnectionParameters(param1:IConnection) : void
      {
         var _loc2_:SSOTicketMessageComposer = null;
         param1.send(new VersionCheckMessageComposer(401,var_2877,var_4879));
         var _loc3_:String = CommunicationUtils.readSOLString("machineid");
         var _loc4_:String = CommunicationUtils.generateFingerprint();
         var _loc5_:Array = Capabilities.version.split(" ");
         param1.send(new UniqueIDMessageComposer(_loc3_,_loc4_,_loc5_.join("/")));
         if(var_538 && var_538.length > 0)
         {
            _loc2_ = new SSOTicketMessageComposer(var_538);
            param1.send(_loc2_);
         }
      }
      
      public function loginOk() : void
      {
         var_2239 = false;
         if(var_88 != null)
         {
            var_88.closeLoginWindow();
            var_88.dispose();
            var_88 = null;
         }
         var_3638 = false;
      }
      
      public function alert(param1:String, param2:String) : void
      {
         var titleKey:String = param1;
         var messageKey:String = param2;
         _windowManager.alert(titleKey,messageKey,0,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
      
      public function dispatchLoginStepEvent(param1:String) : void
      {
         if(class_17(context) == null || class_17(context).events == null)
         {
            return;
         }
         class_17(context).events.dispatchEvent(new Event(param1));
      }
      
      private function unloading(param1:Event) : void
      {
         _logoutInProgress = true;
      }
      
      public function onUserList(param1:Vector.<AvatarData>) : void
      {
         var _loc3_:String = null;
         var _loc2_:Timer = null;
         if(_autoLogin)
         {
            _loc3_ = CommunicationUtils.readSOLString("useruniqueid");
            if(userExists(param1,_loc3_))
            {
               _loc2_ = new Timer(500,1);
               _loc2_.addEventListener("timerComplete",onAutoSendLogin);
               _loc2_.start();
            }
            else
            {
               var_88.populateCharacterList(param1);
            }
         }
         else
         {
            var_88.populateCharacterList(param1);
         }
      }
      
      private function onAutoSendLogin(param1:TimerEvent) : void
      {
         var _loc2_:int = CommunicationUtils.readSOLInteger("userid");
         sendTryLoginDevelopmentOnly(_loginName,var_2861,_loc2_);
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
      
      public function disconnected(param1:int, param2:String) : void
      {
         var_2239 = true;
         if(!var_88)
         {
            if(param2 == null || param2.length < 6)
            {
               param2 = _localization.getLocalization(DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(param1));
            }
            var _loc3_:String = "connection.login.logged_out";
            _localization.registerParameter(null,"reason",param1.toString());
            _localization.registerParameter(null,"reasonName",param2);
            alert(DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(param1),"${connection.login.logged_out}");
            return;
         }
         onBufferedDisconnected(param1,param2);
      }
      
      private function onBufferedDisconnected(param1:int, param2:String) : void
      {
         var _loc5_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:* = false;
         if(param1 == 20)
         {
            var_88.showInvalidLoginError(null);
         }
         else
         {
            _loc5_ = _loginName && _loginName.length && var_2861 && var_2861.length;
            _loc3_ = CommunicationUtils.readSOLString("loginmethod","habbo");
            _loc4_ = _loc3_ == "facebook";
            if(param1 != -3 || !_loc5_ && !_loc4_ || true)
            {
               var_88.showDisconnected(param1,param2);
               if(_communication)
               {
                  _communication.disconnect();
               }
            }
            else
            {
               var_3638 = true;
               CommunicationUtils.forcedAutoLoginEnabled = true;
               initComponent();
            }
         }
      }
      
      public function handleErrorMessage(param1:int, param2:int) : void
      {
         switch(param1)
         {
            case 0:
               localization.registerParameter("connection.server.error.desc","errorCode",String(param1));
               alert("${connection.server.error.title}","${connection.server.error.desc}");
               break;
            case 1001:
            case 1002:
            case 1003:
            case 1004:
            case 1005:
            case 1006:
            case 1007:
            case 1008:
            case 1009:
            case 1010:
            case 1011:
            case 1012:
            case 1013:
            case 1014:
            case 1015:
            case 1016:
            case 1017:
            case 1018:
            case 1019:
               _communication.connection.close();
               break;
            case 4013:
               alert("${connection.room.maintenance.title}","${connection.room.maintenance.desc}");
               break;
            default:
               localization.registerParameter("connection.server.error.desc","errorCode",String(param1));
               alert("${connection.server.error.title}","${connection.server.error.desc}");
         }
      }
      
      private function onCoreError(param1:ErrorEvent) : void
      {
         switch(param1.category)
         {
            case 30:
            case 29:
            case 1:
            case 3:
            case 20:
            case 8:
            case 12:
            case 7:
               if(param1.critical && !isExcludeFromCrashing(param1.category))
               {
                  disconnected(-2,_localization.getLocalization("disconnected.reason.maintenance"));
               }
               break;
            default:
               handleNonMaintenanceCoreError(param1);
         }
      }
      
      private function handleNonMaintenanceCoreError(param1:ErrorEvent) : void
      {
         if(param1.error != null && param1.error.errorID != param1.category)
         {
         }
         var _loc2_:Boolean = isExcludeFromWarnings(param1.category) || !param1.critical && !getBoolean("error_handling.show_error.include_non_critical");
         if(!_loc2_ && getBoolean("error_handling.show_error"))
         {
            var_2090.onError(param1,getBoolean("error_handling.show_stacktrace"));
         }
         if(param1.critical && !isExcludeFromCrashing(param1.category) && getBoolean("error_handling.crash_on_critical_error"))
         {
            disconnected(-1,DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(-1));
         }
      }
      
      private function isExcludeFromWarnings(param1:int) : Boolean
      {
         return isExcludedFromListProperty(param1,"error_handling.exclude_warnings");
      }
      
      private function isExcludeFromCrashing(param1:int) : Boolean
      {
         return isExcludedFromListProperty(param1,"error_handling.exclude_crashing");
      }
      
      private function isExcludedFromListProperty(param1:int, param2:String) : Boolean
      {
         var _loc3_:String = getProperty(param2);
         if(!_loc3_)
         {
            return false;
         }
         var _loc4_:Array = _loc3_.split(",");
         return _loc4_.indexOf(param1.toString()) != -1;
      }
      
      public function handleLoginFailedHotelClosedMessage(param1:int, param2:int) : void
      {
         if(var_88)
         {
            var_88.showDisconnectedWithText(12);
         }
      }
      
      private function updateEnvironmentVariables(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         _loc4_ = [];
         _loc4_.push("connection.info.host");
         _loc4_.push("connection.info.port");
         _loc4_.push("url.prefix");
         _loc4_.push("site.url");
         _loc4_.push("flash.dynamic.download.url");
         _loc4_.push("flash.dynamic.download.name.template");
         _loc4_.push("flash.dynamic.avatar.download.configuration");
         _loc4_.push("flash.dynamic.avatar.download.url");
         _loc4_.push("pocket.api");
         _loc4_.push("web.api");
         _loc4_.push("facebook.application.id");
         _loc4_.push("web.terms_of_service.link");
         for each(var _loc3_ in _loc4_)
         {
            _loc2_ = getProperty(_loc3_);
            _loc5_ = _loc3_ + "." + param1;
            if(propertyExists(_loc5_))
            {
               setProperty(_loc3_,getProperty(_loc5_));
            }
            else
            {
               setProperty(_loc3_,_loc2_);
            }
         }
      }
      
      private function onHotelViewError(param1:Event) : void
      {
         disconnected(-2,_localization.getLocalization("disconnected.reason.maintenance"));
      }
      
      public function get isRoomViewerMode() : Boolean
      {
         return HabboComponentFlags.isRoomViewerMode(flags);
      }
   }
}

