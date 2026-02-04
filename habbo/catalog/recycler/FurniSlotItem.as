package com.sulake.habbo.catalog.recycler
{
   public class FurniSlotItem
   {
      
      private var var_197:int = 0;
      
      private var var_191:int = 0;
      
      private var var_3814:int = 0;
      
      private var var_4301:String = null;
      
      public function FurniSlotItem(param1:int, param2:int, param3:int = 0, param4:String = null)
      {
         super();
         var_197 = param1;
         var_191 = param2;
         var_3814 = param3;
         var_4301 = param4;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get typeId() : int
      {
         return var_3814;
      }
      
      public function get xxxExtra() : String
      {
         return var_4301;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
   }
}

