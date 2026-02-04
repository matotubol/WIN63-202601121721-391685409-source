package com.sulake.core.localization
{
   public class LocalizationDefinition implements ILocalizationDefinition
   {
      
      private var var_3409:String;
      
      private var var_3758:String;
      
      private var var_3505:String;
      
      private var _name:String;
      
      private var var_989:String;
      
      public function LocalizationDefinition(param1:String, param2:String, param3:String)
      {
         super();
         var _loc4_:Array = param1.split("_");
         var_3409 = _loc4_[0];
         var _loc5_:Array = String(_loc4_[1]).split(".");
         var_3758 = _loc5_[0];
         var_3505 = _loc5_[1];
         _name = param2;
         var_989 = param3;
      }
      
      public function get id() : String
      {
         return var_3409 + "_" + var_3758 + "." + var_3505;
      }
      
      public function get languageCode() : String
      {
         return var_3409;
      }
      
      public function get countryCode() : String
      {
         return var_3758;
      }
      
      public function get encoding() : String
      {
         return var_3505;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get url() : String
      {
         return var_989;
      }
   }
}

