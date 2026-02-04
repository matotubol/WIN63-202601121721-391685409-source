package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.desktop.Clipboard;
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   
   public class ErrorPopupCtrl extends class_17
   {
      
      private var _localizationManager:class_27;
      
      private var _windowManager:class_38;
      
      private var _sessionData:ISessionDataManager;
      
      private var var_393:IModalDialog;
      
      private var _window:class_2250;
      
      private var _doNotShowAgain:Boolean = false;
      
      private var var_1134:Boolean = false;
      
      public function ErrorPopupCtrl(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      private static function base64encode(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         var _loc3_:Base64Encoder = new Base64Encoder();
         _loc3_.encodeBytes(_loc2_);
         return _loc3_.toString();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
      }
      
      private function createWindow() : void
      {
         if(var_393 == null)
         {
            var_393 = _windowManager.buildModalDialogFromXML(XML(XmlAsset(assets.getAssetByName("error_popup")).content));
            _window = var_393.rootWindow as class_2250;
            closeButton.addEventListener("WME_CLICK",onWindowCloseClicked);
            okButton.addEventListener("WME_CLICK",onWindowCloseClicked);
            copyButton.addEventListener("WME_CLICK",onCopyClicked);
         }
         _window.activate();
         _window.center();
      }
      
      private function onCopyClicked(param1:WindowMouseEvent) : void
      {
         Clipboard.generalClipboard.clear();
         Clipboard.generalClipboard.setData("air:text",errorInfoContents.text);
      }
      
      private function onWindowCloseClicked(param1:WindowMouseEvent) : void
      {
         _doNotShowAgain = doNotShowCheckbox.isSelected;
         destroyWindow();
      }
      
      private function destroyWindow() : void
      {
         if(var_393 != null)
         {
            var_393.dispose();
            var_393 = null;
         }
      }
      
      public function onError(param1:ErrorEvent, param2:Boolean) : void
      {
         if(_doNotShowAgain)
         {
            return;
         }
         createWindow();
         var _loc3_:Boolean = param2 && param1.error != null;
         errorInfoBorder.visible = _loc3_;
         closeButton.visible = _loc3_;
         messageText.text = param1.error?.message;
         _window.caption = "Error #" + param1.category;
         if(_loc3_)
         {
            errorInfoContents.text = base64encode(createErrorText(param1));
         }
         _window.height = contentList.height + 56;
      }
      
      public function createErrorText(param1:ErrorEvent) : String
      {
         return "Error ID: " + param1.error.errorID + "\n" + "Critical: " + param1.critical + "\n" + "Message: " + param1.message + "\n" + "User name: " + _sessionData.userName + "\n" + "User id:" + _sessionData.userId + "\n" + "Hotel: " + getProperty("environment.id") + "\n" + "---------------------" + "\n\n" + param1.error.getStackTrace();
      }
      
      override public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_1134 = true;
         if(_window)
         {
            destroyWindow();
         }
         _windowManager = null;
         _localizationManager = null;
         _doNotShowAgain = false;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get contentList() : IItemListWindow
      {
         return _window.findChildByName("content_list") as IItemListWindow;
      }
      
      public function get messageText() : ITextWindow
      {
         return _window.findChildByName("error_msg_text") as ITextWindow;
      }
      
      public function get errorInfoBorder() : class_1993
      {
         return _window.findChildByName("error_info_border") as class_1993;
      }
      
      public function get errorInfoContents() : ITextFieldWindow
      {
         return _window.findChildByName("error_info_contents") as ITextFieldWindow;
      }
      
      public function get doNotShowCheckbox() : class_1885
      {
         return _window.findChildByName("do_not_show_cbx") as class_1885;
      }
      
      public function get okButton() : class_1775
      {
         return _window.findChildByName("ok_button") as class_1775;
      }
      
      public function get copyButton() : class_1775
      {
         return _window.findChildByName("copy_button") as class_1775;
      }
      
      public function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close") as class_1741;
      }
   }
}

