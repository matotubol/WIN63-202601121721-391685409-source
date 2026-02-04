package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetChatInputContentUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const CHAT_INPUT_CONTENT:String = "RWWCIDE_CHAT_INPUT_CONTENT";
      
      public static const MESSAGE_TYPE_WHISPER:String = "whisper";
      
      public static const MESSAGE_TYPE_SHOUT:String = "shout";
      
      private var var_4018:String = "";
      
      private var _userName:String = "";
      
      public function RoomWidgetChatInputContentUpdateEvent(param1:String, param2:String = null, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWWCIDE_CHAT_INPUT_CONTENT",param3,param4);
         var_4018 = param1;
         _userName = param2;
      }
      
      public function get messageType() : String
      {
         return var_4018;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

