package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConvertedRoomIdEventParser implements IMessageParser
   {
      
      private var var_2893:String;
      
      private var var_4120:int;
      
      public function ConvertedRoomIdEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2893 = param1.readString();
         var_4120 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2893 = null;
         return true;
      }
      
      public function get globalId() : String
      {
         return var_2893;
      }
      
      public function get convertedId() : int
      {
         return var_4120;
      }
   }
}

