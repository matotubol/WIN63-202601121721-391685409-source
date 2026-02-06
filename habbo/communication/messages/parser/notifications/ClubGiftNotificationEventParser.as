package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ClubGiftNotificationEventParser implements IMessageParser
   {
      
      private var var_3922:int;
      
      public function ClubGiftNotificationEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3922 = param1.readInteger();
         return true;
      }
      
      public function get numGifts() : int
      {
         return var_3922;
      }
   }
}

