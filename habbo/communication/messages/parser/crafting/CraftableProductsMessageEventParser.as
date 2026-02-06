package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftableProductsMessageEventParser implements IMessageParser
   {
      
      private var var_1977:Vector.<class_2398> = new Vector.<class_2398>(0);
      
      private var var_2080:Vector.<String> = new Vector.<String>(0);
      
      public function CraftableProductsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1977 = new Vector.<class_2398>(0);
         var_2080 = new Vector.<String>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_1977.push(new class_2398(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_2080.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get recipeProductItems() : Vector.<class_2398>
      {
         return var_1977;
      }
      
      public function get usableInventoryFurniClasses() : Vector.<String>
      {
         return var_2080;
      }
      
      public function hasData() : Boolean
      {
         return var_1977.length > 0 || var_2080.length > 0;
      }
   }
}

