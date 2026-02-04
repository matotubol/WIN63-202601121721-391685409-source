package com.sulake.habbo.avatar.animation
{
   public class AddDataContainer
   {
      
      private var var_197:String;
      
      private var var_3336:String;
      
      private var var_2399:String;
      
      private var var_3689:String;
      
      private var var_916:Number = 1;
      
      public function AddDataContainer(param1:XML)
      {
         super();
         var_197 = String(param1.@id);
         var_3336 = String(param1.@align);
         var_2399 = String(param1.@base);
         var_3689 = String(param1.@ink);
         var _loc2_:String = String(param1.@blend);
         if(_loc2_.length > 0)
         {
            var_916 = Number(_loc2_);
            if(var_916 > 1)
            {
               var_916 /= 100;
            }
         }
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get align() : String
      {
         return var_3336;
      }
      
      public function get base() : String
      {
         return var_2399;
      }
      
      public function get ink() : String
      {
         return var_3689;
      }
      
      public function get blend() : Number
      {
         return var_916;
      }
      
      public function get isBlended() : Boolean
      {
         return var_916 != 1;
      }
   }
}

