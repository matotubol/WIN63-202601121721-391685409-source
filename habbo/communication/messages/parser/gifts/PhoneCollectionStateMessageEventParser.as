package com.sulake.habbo.communication.messages.parser.gifts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PhoneCollectionStateMessageEventParser implements IMessageParser
   {
      
      private var var_3384:int;
      
      private var var_4133:int;
      
      private var var_2948:int;
      
      public function PhoneCollectionStateMessageEventParser()
      {
         super();
      }
      
      public function get phoneStatusCode() : int
      {
         return var_3384;
      }
      
      public function get collectionStatusCode() : int
      {
         return var_4133;
      }
      
      public function get millisecondsToAllowProcessReset() : int
      {
         return var_2948;
      }
      
      public function flush() : Boolean
      {
         var_3384 = -1;
         var_2948 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3384 = param1.readInteger();
         var_4133 = param1.readInteger();
         var_2948 = param1.readInteger();
         return true;
      }
   }
}

