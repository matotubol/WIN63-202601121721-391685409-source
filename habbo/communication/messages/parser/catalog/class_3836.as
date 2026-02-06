package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3836 implements IMessageParser
   {
      
      private var _offerId:int;
      
      private var var_4690:Boolean;
      
      public function class_3836()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offerId = param1.readInteger();
         var_4690 = param1.readBoolean();
         return true;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get isGiftable() : Boolean
      {
         return var_4690;
      }
   }
}

