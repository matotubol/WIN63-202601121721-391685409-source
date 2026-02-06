package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveMultipleMessageEventParser implements IMessageParser
   {
      
      private var var_3277:Array;
      
      private var var_2760:int;
      
      public function ObjectRemoveMultipleMessageEventParser()
      {
         super();
      }
      
      public function get ids() : Array
      {
         return var_3277;
      }
      
      public function get pickerId() : int
      {
         return var_2760;
      }
      
      public function flush() : Boolean
      {
         var_3277 = [];
         var_2760 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = param1.readInteger();
         var_3277 = [];
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            ids.push(param1.readInteger());
            _loc3_++;
         }
         var_2760 = param1.readInteger();
         return true;
      }
   }
}

