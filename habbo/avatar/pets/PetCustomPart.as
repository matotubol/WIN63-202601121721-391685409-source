package com.sulake.habbo.avatar.pets
{
   public class PetCustomPart
   {
      
      private var var_3061:int;
      
      private var var_2953:int;
      
      private var var_3349:int;
      
      public function PetCustomPart(param1:int, param2:int, param3:int)
      {
         super();
         var_3061 = param1;
         var_2953 = param2;
         var_3349 = param3;
      }
      
      public function get paletteId() : int
      {
         return var_3349;
      }
      
      public function set paletteId(param1:int) : void
      {
         var_3349 = param1;
      }
      
      public function get partId() : int
      {
         return var_2953;
      }
      
      public function set partId(param1:int) : void
      {
         var_2953 = param1;
      }
      
      public function get layerId() : int
      {
         return var_3061;
      }
      
      public function set layerId(param1:int) : void
      {
         var_3061 = param1;
      }
   }
}

