package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsBadgeRequestFulfilledEventParser implements IMessageParser
   {
      
      private var var_4225:String;
      
      private var var_5020:Boolean;
      
      public function IsBadgeRequestFulfilledEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4225 = param1.readString();
         var_5020 = param1.readBoolean();
         return true;
      }
      
      public function get requestCode() : String
      {
         return var_4225;
      }
      
      public function get fulfilled() : Boolean
      {
         return var_5020;
      }
   }
}

