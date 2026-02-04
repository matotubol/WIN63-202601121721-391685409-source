package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import package_122.class_2446;
   import package_79.class_3291;
   
   public class SendMsgsCtrl implements class_13, ITrackedWindow
   {
      
      private static const TOPIC_ID_NOT_SELECTED:int = -999;
      
      private var _main:ModerationManager;
      
      private var var_696:int;
      
      private var _targetUserName:String;
      
      private var var_2726:class_3291;
      
      private var _frame:class_2250;
      
      private var _msgSelect:class_2261;
      
      private var var_878:ITextFieldWindow;
      
      private var _disposed:Boolean;
      
      private var _placeHolderMessage:Boolean = true;
      
      public function SendMsgsCtrl(param1:ModerationManager, param2:int, param3:String, param4:class_3291)
      {
         super();
         _main = param1;
         var_696 = param2;
         _targetUserName = param3;
         var_2726 = param4;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_2250(_main.getXmlWindow("send_msgs"));
         _frame.caption = "Msg To: " + _targetUserName;
         _frame.findChildByName("send_message_but").procedure = onSendMessageButton;
         var_878 = ITextFieldWindow(_frame.findChildByName("message_input"));
         var_878.procedure = onInputClick;
         _msgSelect = class_2261(_frame.findChildByName("msgTemplatesSelect"));
         prepareMessageSelection(_msgSelect);
         _msgSelect.procedure = onSelectTemplate;
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 2;
      }
      
      public function getId() : String
      {
         return _targetUserName;
      }
      
      public function getFrame() : class_2250
      {
         return _frame;
      }
      
      private function prepareMessageSelection(param1:class_2261) : void
      {
         class_21.log("MSG TEMPLATES: " + _main.initMsg.messageTemplates.length);
         param1.populate(_main.initMsg.messageTemplates);
      }
      
      private function onSelectTemplate(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc3_:String = _main.initMsg.messageTemplates[_msgSelect.selection];
         if(_loc3_ != null)
         {
            _placeHolderMessage = false;
            var_878.text = _loc3_;
         }
      }
      
      private function onSendMessageButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_placeHolderMessage || var_878.text == "")
         {
            _main.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         class_21.log("Sending message...");
         _main.connection.send(new class_2446(var_696,var_878.text,-999,var_2726 != null ? var_2726.issueId : -1));
         this.dispose();
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onInputClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(_placeHolderMessage)
         {
            var_878.text = "";
            _placeHolderMessage = false;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _msgSelect = null;
         var_878 = null;
         _main = null;
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
   }
}

