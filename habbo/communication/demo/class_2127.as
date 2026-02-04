package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.*;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.login.AvatarData;
   import com.sulake.habbo.communication.login.ILoginViewer;
   import com.sulake.habbo.communication.login.class_262;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class class_2127 extends EventDispatcherWrapper implements ILoginViewer
   {
      
      public static const INIT_LOGIN:String = "INIT_LOGIN";
      
      public static const AVATAR_SELECTED:String = "AVATAR_SELECTED";
      
      public static const ENVIRONMENT_SELECTED:String = "ENVIRONMENT_SELECTED";
      
      private var var_1635:class_16;
      
      private var var_3755:class_38;
      
      private var var_3477:class_40;
      
      private var var_393:IModalDialog;
      
      private var _window:class_1812;
      
      private var var_4406:Boolean = false;
      
      public var name:String = "";
      
      public var password:String = "";
      
      private var var_3719:Dictionary;
      
      private var var_5018:class_1741;
      
      private var var_959:class_1775;
      
      private var var_749:ITextFieldWindow;
      
      private var var_1378:ITextFieldWindow;
      
      private var var_483:class_2954;
      
      private var var_2699:int;
      
      private var var_2147:Vector.<AvatarData>;
      
      private var var_5139:AvatarData;
      
      public function class_2127(param1:class_16, param2:class_40, param3:class_38)
      {
         super();
         var_1635 = param1;
         var_3477 = param2;
         var_3755 = param3;
         var_3719 = new Dictionary();
         var_393 = getModalXmlWindow("login_window",var_3477,var_3755,"");
         _window = var_393.rootWindow as class_1812;
         createWindow();
      }
      
      public static function getModalXmlWindow(param1:String, param2:class_40, param3:class_38, param4:String = "_xml") : IModalDialog
      {
         var _loc7_:IAsset = null;
         var _loc5_:XmlAsset = null;
         var _loc6_:IModalDialog = null;
         try
         {
            _loc7_ = param2.getAssetByName(param1 + param4);
            _loc5_ = XmlAsset(_loc7_);
            _loc6_ = param3.buildModalDialogFromXML(XML(_loc5_.content));
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("Communication","Failed to build modal window " + param1 + "_xml, " + _loc7_ + "!");
            throw e;
         }
         return _loc6_;
      }
      
      public function get avatarId() : int
      {
         return var_2699;
      }
      
      public function get selectedAccount() : AvatarData
      {
         return var_5139;
      }
      
      public function get selectedEnvironment() : String
      {
         return var_483.selectedEnvironment;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_393)
         {
            var_393.dispose();
            var_393 = null;
         }
         if(var_483)
         {
            var_483.removeEventListener("ENVIRONMENT_SELECTED_EVENT",onEnvironmentSelected);
            var_483.dispose();
            var_483 = null;
         }
         var_3719 = null;
      }
      
      public function closeLoginWindow() : void
      {
         if(var_393)
         {
            var_393.dispose();
            var_393 = null;
         }
      }
      
      public function get useWebApi() : Boolean
      {
         var _loc1_:ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
         if(_loc1_ != null)
         {
            return _loc1_.isSelected;
         }
         return false;
      }
      
      public function get useExistingSession() : Boolean
      {
         return false;
      }
      
      private function createWindow() : void
      {
         _window.center();
         _window.caption += " (air)";
         _window.findChildByName("useExistingSession").disable();
         _window.findChildByName("useExistingSession").blend = 0.5;
         var_959 = _window.findChildByName("login_btn") as class_1775;
         var_749 = _window.findChildByName("name_field") as ITextFieldWindow;
         var_1378 = _window.findChildByName("pwd_field") as ITextFieldWindow;
         var _loc3_:String = CommunicationUtils.readSOLString("environment");
         var_959.addEventListener("WME_CLICK",windowEventProcessor);
         var_959.caption = _loc3_ == null ? "Select environment above" : "Initializing (" + _loc3_ + ")";
         var_959.disable();
         if(var_749 != null)
         {
            var_749.textBackground = true;
            var_749.textBackgroundColor = 16777215;
            var_749.text = CommunicationUtils.readSOLString("login");
            var_749.focus();
            var_749.setSelection(var_749.text.length,var_749.text.length);
            var_749.addEventListener("WKE_KEY_UP",windowEventProcessor);
         }
         if(var_1378 != null)
         {
            var_1378.textBackground = true;
            var_1378.textBackgroundColor = 16777215;
            var_1378.text = CommunicationUtils.restorePassword();
            var_1378.addEventListener("WKE_KEY_UP",windowEventProcessor);
         }
         var _loc2_:ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
         _loc2_.addEventListener("WME_CLICK",windowEventProcessorCheckbox);
         if(_loc2_)
         {
            _loc2_.select();
         }
         var _loc1_:ISelectableWindow = _window.findChildByName("useExistingSession") as ISelectableWindow;
         if(_loc1_)
         {
            _loc1_.unselect();
         }
         if(var_1635.getBoolean("try.existing.session"))
         {
            var_4406 = true;
            _window.visible = false;
            windowEventProcessor(class_1758.allocate("WE_OK",_window,null,false));
         }
         var _loc4_:IItemListWindow = _window.findChildByName("list") as IItemListWindow;
         var_5018 = _loc4_.removeListItemAt(0);
         var_483 = new class_2954(_window.findChildByName("environment_list") as class_2466,var_1635,var_3755,var_3477);
         var_483.addEventListener("ENVIRONMENT_SELECTED_EVENT",onEnvironmentSelected);
      }
      
      private function onEnvironmentSelected(param1:Event = null) : void
      {
         dispatchEvent(new Event("ENVIRONMENT_SELECTED"));
         var_959.disable();
         var_959.caption = "Initializing (" + var_483.selectedEnvironment + ")";
         showInfoMessage("Initializing Web Api connection to (" + var_483.getEnvironmentName(var_483.selectedEnvironment) + ")");
      }
      
      public function populateUserList(param1:class_55) : void
      {
         var _loc3_:class_1741 = null;
         var _loc4_:int = 0;
         var _loc5_:IItemListWindow = _window.findChildByName("list") as IItemListWindow;
         if(!_loc5_)
         {
            return;
         }
         _window.findChildByName("users_info").visible = false;
         var _loc2_:class_1741 = var_5018.clone();
         _loc2_.procedure = listEventHandler;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = _loc2_.clone();
            _loc3_.id = param1.getKey(_loc4_);
            _loc3_.caption = param1.getWithIndex(_loc4_);
            _loc5_.addListItem(_loc3_);
            _loc4_++;
         }
         _loc2_.dispose();
      }
      
      public function displayResults(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.findChildByName("text002") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function handleKeyUp(param1:WindowKeyboardEvent) : void
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc5_:ITextFieldWindow = null;
         var _loc2_:ITextFieldWindow = null;
         var _loc7_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc7_.ctrlKey)
         {
            _loc3_ = _loc7_.keyCode - 49;
            if(_loc3_ >= 0 && _loc3_ < 10)
            {
               _loc6_ = var_1635.getProperty("login.user." + _loc3_ + ".name");
               _loc4_ = var_1635.getProperty("login.user." + _loc3_ + ".pass");
               _loc5_ = _window.findChildByName("name_field") as ITextFieldWindow;
               _loc2_ = _window.findChildByName("pwd_field") as ITextFieldWindow;
               if(_loc6_ != "")
               {
                  _loc5_.caption = _loc6_;
               }
               if(_loc4_ != "")
               {
                  _loc2_.caption = _loc4_;
               }
               _loc5_.setSelection(_loc5_.text.length,_loc5_.text.length);
               if(_loc7_.cancelable)
               {
                  _loc7_.preventDefault();
                  _loc7_.preventWindowOperation();
               }
               param1.stopImmediatePropagation();
               param1.stopPropagation();
            }
         }
      }
      
      private function windowEventProcessor(param1:class_1758 = null, param2:class_1741 = null) : void
      {
         if(param1.type == "WKE_KEY_UP")
         {
            handleKeyUp(param1 as WindowKeyboardEvent);
            if((param1 as WindowKeyboardEvent).keyCode != 13)
            {
               return;
            }
         }
         if(var_749 != null)
         {
            name = var_749.text;
         }
         if(var_1378 != null)
         {
            password = var_1378.text;
         }
         CommunicationUtils.writeSOLProperty("login",name);
         dispatchEvent(new Event("INIT_LOGIN"));
         var_959.disable();
      }
      
      private function windowEventProcessorCheckbox(param1:class_1758 = null, param2:class_1741 = null) : void
      {
         var_959.enable();
      }
      
      private function listEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(useWebApi)
         {
            var_5139 = var_2147[param2.id];
         }
         else
         {
            var_2699 = var_2147[param2.id].id;
         }
         dispatchEvent(new Event("AVATAR_SELECTED"));
      }
      
      public function showError(param1:int, param2:int, param3:String) : void
      {
         _window.findChildByName("users_info").caption = "Received error: " + param1 + " regarding message: " + param2;
      }
      
      private function showErrorMessage(param1:String) : void
      {
         _window.findChildByName("users_info").caption = "Error:\n\n" + param1;
      }
      
      private function showInfoMessage(param1:String) : void
      {
         _window.findChildByName("users_info").caption = param1;
      }
      
      public function showLoginScreen() : void
      {
      }
      
      public function showRegistrationError(param1:Object) : void
      {
         showErrorMessage("Registration error");
      }
      
      public function showInvalidLoginError(param1:Object) : void
      {
         showErrorMessage("Invalid login");
      }
      
      public function nameCheckResponse(param1:Object, param2:Boolean) : void
      {
      }
      
      public function showCaptchaError() : void
      {
         showErrorMessage("Captcha required, please add your IP to Housekeeping property to avoid this.");
      }
      
      public function showAccountError(param1:Object) : void
      {
         showErrorMessage("Error with account during login");
      }
      
      public function showLoadingScreen() : void
      {
         dispose();
      }
      
      public function saveLooksError(param1:Object) : void
      {
         showErrorMessage("Save looks error ");
      }
      
      public function showTOS() : void
      {
         showErrorMessage("Web-api wants to show Terms of Service");
      }
      
      public function environmentReady() : void
      {
         var_959.enable();
         var_959.caption = "Login (" + var_483.selectedEnvironment + ")";
         showInfoMessage("Web Api connection is established for (" + var_483.getEnvironmentName(var_483.selectedEnvironment) + "). Ready to connect.");
      }
      
      public function populateCharacterList(param1:Vector.<AvatarData>) : void
      {
         var_2147 = param1;
         var _loc6_:String = CommunicationUtils.readSOLString("useruniqueid");
         var _loc2_:class_55 = new class_55();
         var _loc4_:int = 0;
         for each(var _loc5_ in param1)
         {
            if(_loc5_.uniqueId == _loc6_)
            {
               var _loc3_:AvatarData = _loc5_;
            }
            _loc2_[_loc4_] = _loc5_.name;
            _loc4_++;
         }
         populateUserList(_loc2_);
      }
      
      public function showSelectAvatar(param1:Object) : void
      {
      }
      
      public function showPromoHabbos(param1:XML) : void
      {
      }
      
      public function showSelectRoom() : void
      {
      }
      
      public function showDisconnectedWithText(param1:int) : void
      {
         showErrorMessage("Hotel is closed");
      }
      
      public function showDisconnected(param1:int, param2:String) : void
      {
         showErrorMessage("Disconnected reason: " + param2 + " (" + param1 + ")");
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return var_1635 ? var_1635.getProperty(param1,param2) : "";
      }
      
      public function createCaptchaView() : class_262
      {
         return undefined;
      }
      
      public function captchaReady() : void
      {
      }
   }
}

