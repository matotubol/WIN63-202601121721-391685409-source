package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RequestSpamWallPostItMessageEventParser implements IMessageParser
   {
      
      private var var_2529:int;
      
      private var var_559:String;
      
      public function RequestSpamWallPostItMessageEventParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return var_2529;
      }
      
      public function get location() : String
      {
         return var_559;
      }
      
      public function flush() : Boolean
      {
         var_2529 = -1;
         var_559 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2529 = param1.readInteger();
         var_559 = param1.readString();
         return true;
      }
   }
}

