package com.sulake.habbo.communication.messages.parser.landingview
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_101.class_4098;
   
   [SecureSWF(rename="true")]
   public class class_3928 implements IMessageParser
   {
      
      private var var_993:Array;
      
      public function class_3928()
      {
         super();
      }
      
      public function get articles() : Array
      {
         return var_993;
      }
      
      public function flush() : Boolean
      {
         var_993 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_993.push(new class_4098(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

