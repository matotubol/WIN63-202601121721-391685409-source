package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipesAvailableMessageEventParser implements IMessageParser
   {
      
      private var var_3133:Boolean;
      
      private var _count:int;
      
      public function CraftingRecipesAvailableMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _count = param1.readInteger();
         var_3133 = param1.readBoolean();
         return true;
      }
      
      public function flush() : Boolean
      {
         _count = 0;
         var_3133 = false;
         return true;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get recipeComplete() : Boolean
      {
         return var_3133;
      }
   }
}

