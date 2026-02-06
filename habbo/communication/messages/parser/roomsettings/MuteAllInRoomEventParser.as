package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MuteAllInRoomEventParser implements IMessageParser
   {
      
      private var var_4807:Boolean;
      
      public function MuteAllInRoomEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4807 = param1.readBoolean();
         return true;
      }
      
      public function get allMuted() : Boolean
      {
         return var_4807;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}

