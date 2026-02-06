package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2347
   {
      
      private var _count:int;
      
      private var var_2783:String;
      
      public function class_2347(param1:IMessageDataWrapper)
      {
         super();
         _count = param1.readInteger();
         var_2783 = param1.readString();
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get furnitureClassName() : String
      {
         return var_2783;
      }
   }
}

