package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSettingsEventParser implements IMessageParser
   {
      
      private var var_3102:int;
      
      private var var_2260:int;
      
      public function NavigatorSettingsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3102 = param1.readInteger();
         var_2260 = param1.readInteger();
         return true;
      }
      
      public function get homeRoomId() : int
      {
         return var_3102;
      }
      
      public function get roomIdToEnter() : int
      {
         return var_2260;
      }
   }
}

