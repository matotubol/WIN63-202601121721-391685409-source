package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_2527 implements IMessageParser
   {
      
      private var var_61:*;
      
      private var var_2928:int;
      
      private var var_1940:class_2870;
      
      public function class_2527()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_61 = -1;
         var_2928 = -1;
         var_1940 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_61 = param1.readShort();
         var_2928 = param1.readInteger();
         var_1940 = new class_2870(param1);
         return true;
      }
      
      public function get start() : Boolean
      {
         return var_61 == 0;
      }
      
      public function get finish() : Boolean
      {
         return var_61 == 1;
      }
      
      public function get state() : *
      {
         return var_61;
      }
      
      public function get openerAvatarId() : int
      {
         return var_2928;
      }
      
      public function get reward() : class_2870
      {
         return var_1940;
      }
   }
}

