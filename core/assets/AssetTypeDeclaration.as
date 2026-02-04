package com.sulake.core.assets
{
   public class AssetTypeDeclaration
   {
      
      private var var_4676:String;
      
      private var var_4188:Class;
      
      private var var_3953:Class;
      
      private var var_3130:Array;
      
      public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class = null, ... rest)
      {
         super();
         var_4676 = param1;
         var_4188 = param2;
         var_3953 = param3;
         if(rest == null)
         {
            var_3130 = [];
         }
         else
         {
            var_3130 = rest;
         }
      }
      
      public function get mimeType() : String
      {
         return var_4676;
      }
      
      public function get assetClass() : Class
      {
         return var_4188;
      }
      
      public function get loaderClass() : Class
      {
         return var_3953;
      }
      
      public function get fileTypes() : Array
      {
         return var_3130;
      }
   }
}

