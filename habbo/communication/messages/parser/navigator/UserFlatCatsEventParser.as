package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3364;
   
   [SecureSWF(rename="true")]
   public class UserFlatCatsEventParser implements IMessageParser
   {
      
      private var var_2354:Array;
      
      public function UserFlatCatsEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2354 = [];
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_2354.push(new class_3364(param1));
            _loc2_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2354 = null;
         return true;
      }
      
      public function get nodes() : Array
      {
         return var_2354;
      }
   }
}

