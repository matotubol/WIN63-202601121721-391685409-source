package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3362;
   
   [SecureSWF(rename="true")]
   public class FlatControllersEventParser implements IMessageParser
   {
      
      private var var_1951:int;
      
      private var var_3801:Array;
      
      public function FlatControllersEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_3801.push(new class_3362(param1));
            _loc2_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_3801 = [];
         return true;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get controllers() : Array
      {
         return var_3801;
      }
   }
}

