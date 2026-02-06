package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2482;
   
   [SecureSWF(rename="true")]
   public class UserEventCatsEventParser implements IMessageParser
   {
      
      private var var_2672:Array;
      
      public function UserEventCatsEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2672 = [];
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_2672.push(new class_2482(param1));
            _loc2_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2672 = null;
         return true;
      }
      
      public function get eventCategories() : Array
      {
         return var_2672;
      }
   }
}

