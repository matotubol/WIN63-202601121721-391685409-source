package com.sulake.habbo.communication.messages.outgoing.crafting
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class GetCraftingRecipesAvailableComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function GetCraftingRecipesAvailableComposer(param1:int, param2:Vector.<int>)
      {
         super();
         var_120.push(param1);
         var_120.push(param2.length);
         var _loc3_:int = 0;
         while(0 < param2.length)
         {
            var_120.push(param2[0]);
            _loc3_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

