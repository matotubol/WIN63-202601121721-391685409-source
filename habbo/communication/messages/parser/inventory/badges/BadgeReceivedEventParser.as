package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BadgeReceivedEventParser implements IMessageParser
   {
      
      private var var_605:int;
      
      private var var_2806:String;
      
      public function BadgeReceivedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_605 = param1.readInteger();
         var_2806 = param1.readString();
         return true;
      }
      
      public function get badgeId() : int
      {
         return var_605;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
   }
}

