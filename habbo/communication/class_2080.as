package com.sulake.habbo.communication
{
   public interface class_2080
   {
      
      function apiResponse(param1:String, param2:Object) : void;
      
      function apiRawResponse(param1:String, param2:Object) : void;
      
      function apiError(param1:String, param2:int, param3:String, param4:Object, param5:Boolean = false) : void;
   }
}

