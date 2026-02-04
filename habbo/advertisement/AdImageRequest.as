package com.sulake.habbo.advertisement
{
   public class AdImageRequest
   {
      
      private var var_1951:int;
      
      private var var_315:int;
      
      private var var_3874:int;
      
      private var var_4475:String;
      
      private var var_4153:String;
      
      public function AdImageRequest(param1:int, param2:String = null, param3:String = null, param4:int = -1, param5:int = -1)
      {
         super();
         var_1951 = param1;
         var_315 = param4;
         var_3874 = param5;
         var_4475 = param2;
         var_4153 = param3;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectCategory() : int
      {
         return var_3874;
      }
      
      public function get imageURL() : String
      {
         return var_4475;
      }
      
      public function get clickURL() : String
      {
         return var_4153;
      }
   }
}

