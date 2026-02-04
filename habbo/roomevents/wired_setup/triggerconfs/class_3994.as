package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3994 extends DefaultTriggerConf
   {
      
      public function class_3994()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4093.BOT_DESTINATION_REACHED;
      }
      
      override public function readStringParamFromForm() : String
      {
         return getInput(cont).text;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         getInput(cont).text = param1.stringParam;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("bot_name"));
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.bots";
      }
   }
}

