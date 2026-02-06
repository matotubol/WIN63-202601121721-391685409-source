package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetSupplementedNotificationEventParser implements IMessageParser
   {
      
      private var var_2751:int;
      
      private var var_1270:int;
      
      private var var_4873:int;
      
      public function PetSupplementedNotificationEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2751 = param1.readInteger();
         var_1270 = param1.readInteger();
         var_4873 = param1.readInteger();
         return true;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get supplementType() : int
      {
         return var_4873;
      }
   }
}

