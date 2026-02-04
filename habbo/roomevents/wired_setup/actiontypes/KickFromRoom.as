package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class KickFromRoom extends DefaultActionType
   {
      
      public function KickFromRoom()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.KICK_FROM_ROOM;
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
         return ITextFieldWindow(param1.findChildByName("chat_message"));
      }
      
      override public function validate() : String
      {
         var _loc2_:String = null;
         if(getInput(cont).text.length > 100)
         {
            _loc2_ = "wiredfurni.chatmsgtoolong";
            return roomEvents.localization.getLocalization(_loc2_,_loc2_);
         }
         return null;
      }
   }
}

