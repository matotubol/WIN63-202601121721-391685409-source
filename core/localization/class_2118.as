package com.sulake.core.localization
{
   public class class_2118 implements class_1959
   {
      
      private var var_4288:String;
      
      private var _externalTextsHash:String;
      
      private var var_4879:String;
      
      private var _externalVariablesHash:String;
      
      private var var_4316:String;
      
      private var _furniDataHash:String;
      
      private var var_4974:String;
      
      private var _productDataHash:String;
      
      public function class_2118()
      {
         super();
      }
      
      public static function parse(param1:String) : class_2118
      {
         var _loc2_:Object = JSON.parse(param1);
         var _loc4_:class_2118 = new class_2118();
         for each(var _loc3_ in _loc2_.hashes)
         {
            if(_loc3_.name == "external_texts")
            {
               _loc4_.var_4288 = _loc3_.url;
               _loc4_._externalTextsHash = _loc3_.hash;
            }
            else if(_loc3_.name == "external_variables")
            {
               _loc4_.var_4879 = _loc3_.url;
               _loc4_._externalVariablesHash = _loc3_.hash;
            }
            else if(_loc3_.name == "furnidata")
            {
               _loc4_.var_4316 = _loc3_.url;
               _loc4_._furniDataHash = _loc3_.hash;
            }
            else if(_loc3_.name == "productdata")
            {
               _loc4_.var_4974 = _loc3_.url;
               _loc4_._productDataHash = _loc3_.hash;
            }
         }
         return _loc4_;
      }
      
      public function isValid() : Boolean
      {
         return var_4288 && _externalTextsHash && var_4879 && _externalVariablesHash && var_4316 && _furniDataHash && var_4974 && _productDataHash;
      }
      
      public function getExternalTextsUrl() : String
      {
         return var_4288;
      }
      
      public function getExternalTextsHash() : String
      {
         return _externalTextsHash;
      }
      
      public function getExternalVariablesUrl() : String
      {
         return var_4879;
      }
      
      public function getExternalVariablesHash() : String
      {
         return _externalVariablesHash;
      }
      
      public function getFurniDataUrl() : String
      {
         return var_4316;
      }
      
      public function getFurniDataHash() : String
      {
         return _furniDataHash;
      }
      
      public function getProductDataUrl() : String
      {
         return var_4974;
      }
      
      public function getProductDataHash() : String
      {
         return _productDataHash;
      }
   }
}

