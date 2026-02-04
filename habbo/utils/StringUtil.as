package com.sulake.habbo.utils
{
   public class StringUtil
   {
      
      private static const characters:Array = ["p","e",",","i","\"","r","","m","o","}","n","g","","{","x","l",":","q","a","c",":","s","o"," ","(","","p","t","i","v","h","f",""," ","c","d","","k",")","s","z","","y","w","b","-","t","j","","u",":","."," ","a","\"","\"","e","m"," ",","];
      
      public function StringUtil()
      {
         super();
      }
      
      public static function addLeftZeroPadding(param1:String, param2:int) : String
      {
         while(param1.length < param2)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      public static function stripFontTag(param1:String) : String
      {
         var _loc2_:RegExp = /<font[^>]*>/ig;
         param1 = param1.replace(_loc2_,"");
         var _loc3_:RegExp = new RegExp("</font>","ig");
         return param1.replace(_loc3_,"");
      }
      
      public static function trim(param1:String) : String
      {
         return param1 ? param1.replace(/^\s+|\s+$/sg,"") : "";
      }
      
      public static function removeWhiteSpace(param1:String) : String
      {
         return param1 ? param1.replace(/ /sg,"") : "";
      }
      
      public static function toAlphaNumericLow(param1:String) : String
      {
         return param1.toLowerCase().replace(/\W/g,"");
      }
      
      public static function nonNull(param1:String) : String
      {
         return param1 == null ? "" : param1;
      }
      
      public static function isEmpty(param1:String) : Boolean
      {
         return param1 == null || param1.length == 0;
      }
      
      public static function isBlank(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         return trim(param1).length == 0;
      }
      
      public static function makeMagicString(param1:int, ... rest) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = "";
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            _loc3_ += characters[rest[_loc4_] - param1];
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

