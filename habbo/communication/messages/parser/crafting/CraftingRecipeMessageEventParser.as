package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipeMessageEventParser implements IMessageParser
   {
      
      private var var_2313:Vector.<class_2347> = new Vector.<class_2347>(0);
      
      public function CraftingRecipeMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_2313.push(new class_2347(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2313 = new Vector.<class_2347>(0);
         return true;
      }
      
      public function get ingredients() : Vector.<class_2347>
      {
         return var_2313;
      }
   }
}

