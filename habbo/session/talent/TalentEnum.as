package com.sulake.habbo.session.talent
{
   public class TalentEnum
   {
      
      public static const HELPER:String = "helper";
      
      public static const CITIZENSHIP:String = "citizenship";
      
      public function TalentEnum()
      {
         super();
      }
      
      public static function get asArray() : Array
      {
         return ["helper","citizenship"];
      }
   }
}

