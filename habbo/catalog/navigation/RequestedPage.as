package com.sulake.habbo.catalog.navigation
{
   public class RequestedPage
   {
      
      public static const REQUEST_TYPE_NONE:int = 0;
      
      public static const REQUEST_TYPE_ID:int = 1;
      
      public static const REQUEST_TYPE_NAME:int = 2;
      
      private var var_1282:int;
      
      private var var_2563:int;
      
      private var var_3275:int;
      
      private var _requestName:String;
      
      public function RequestedPage()
      {
         super();
         var_1282 = 0;
      }
      
      public function set requestById(param1:int) : void
      {
         var_1282 = 1;
         var_2563 = param1;
      }
      
      public function set requestByName(param1:String) : void
      {
         var_1282 = 2;
         _requestName = param1;
      }
      
      public function resetRequest() : void
      {
         var_1282 = 0;
         var_3275 = -1;
      }
      
      public function get requestType() : int
      {
         return var_1282;
      }
      
      public function get requestId() : int
      {
         return var_2563;
      }
      
      public function get requestedOfferId() : int
      {
         return var_3275;
      }
      
      public function set requestedOfferId(param1:int) : void
      {
         var_3275 = param1;
      }
      
      public function get requestName() : String
      {
         return _requestName;
      }
   }
}

