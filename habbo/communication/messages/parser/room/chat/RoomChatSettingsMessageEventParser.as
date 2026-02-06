package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_2164;
   
   [SecureSWF(rename="true")]
   public class RoomChatSettingsMessageEventParser implements IMessageParser
   {
      
      private var var_2796:class_2164;
      
      public function RoomChatSettingsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2796 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2796 = new class_2164(param1);
         return true;
      }
      
      public function get chatSettings() : class_2164
      {
         return var_2796;
      }
   }
}

