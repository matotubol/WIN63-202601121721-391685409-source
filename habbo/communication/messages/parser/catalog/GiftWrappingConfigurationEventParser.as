package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GiftWrappingConfigurationEventParser implements IMessageParser
   {
      
      private var var_5032:Boolean;
      
      private var var_3954:int;
      
      private var var_2374:Array;
      
      private var var_666:Array;
      
      private var var_1193:Array;
      
      private var var_3415:Array;
      
      public function GiftWrappingConfigurationEventParser()
      {
         super();
      }
      
      public function get isWrappingEnabled() : Boolean
      {
         return var_5032;
      }
      
      public function get wrappingPrice() : int
      {
         return var_3954;
      }
      
      public function get stuffTypes() : Array
      {
         return var_2374;
      }
      
      public function get boxTypes() : Array
      {
         return var_666;
      }
      
      public function get ribbonTypes() : Array
      {
         return var_1193;
      }
      
      public function get defaultStuffTypes() : Array
      {
         return var_3415;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2374 = [];
         var_666 = [];
         var_1193 = [];
         var_3415 = [];
         var_5032 = param1.readBoolean();
         var_3954 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2374.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(0 < _loc2_)
         {
            var_666.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(0 < _loc2_)
         {
            var_1193.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(0 < _loc2_)
         {
            var_3415.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
   }
}

