package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsSavedEventParser implements IMessageParser
   {
      
      private var var_1951:int;
      
      public function RoomSettingsSavedEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         var_1951 = 0;
         return true;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
   }
}

