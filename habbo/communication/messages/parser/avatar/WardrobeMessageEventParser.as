package com.sulake.habbo.communication.messages.parser.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.avatar.class_3930;
   
   [SecureSWF(rename="true")]
   public class WardrobeMessageEventParser implements IMessageParser
   {
      
      private var var_61:int;
      
      private var var_3674:Array;
      
      public function WardrobeMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_61 = 0;
         var_3674 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_61 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:class_3930 = new class_3930(param1);
            var_3674.push(null);
            _loc4_++;
         }
         return true;
      }
      
      public function get outfits() : Array
      {
         return var_3674;
      }
      
      public function get state() : int
      {
         return var_61;
      }
   }
}

