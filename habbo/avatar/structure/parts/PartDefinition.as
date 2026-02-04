package com.sulake.habbo.avatar.structure.parts
{
   public class PartDefinition
   {
      
      private var var_4820:String;
      
      private var var_3104:String;
      
      private var var_4474:String;
      
      private var var_2991:Boolean;
      
      private var var_3496:int = -1;
      
      public function PartDefinition(param1:XML)
      {
         super();
         var_4820 = String(param1["set-type"]);
         var_3104 = String(param1["flipped-set-type"]);
         var_4474 = String(param1["remove-set-type"]);
         var_2991 = false;
      }
      
      public function hasStaticId() : Boolean
      {
         return var_3496 >= 0;
      }
      
      public function get staticId() : int
      {
         return var_3496;
      }
      
      public function set staticId(param1:int) : void
      {
         var_3496 = param1;
      }
      
      public function get setType() : String
      {
         return var_4820;
      }
      
      public function get flippedSetType() : String
      {
         return var_3104;
      }
      
      public function get removeSetType() : String
      {
         return var_4474;
      }
      
      public function get appendToFigure() : Boolean
      {
         return var_2991;
      }
      
      public function set appendToFigure(param1:Boolean) : void
      {
         var_2991 = param1;
      }
      
      public function set flippedSetType(param1:String) : void
      {
         var_3104 = param1;
      }
   }
}

