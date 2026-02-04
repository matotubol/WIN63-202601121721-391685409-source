package com.sulake.habbo.communication
{
   public interface class_261
   {
      
      function get disposed() : Boolean;
      
      function habboWebApiResponse(param1:String, param2:Object) : void;
      
      function habboWebApiRawResponse(param1:String, param2:Object) : void;
      
      function habboWebApiError(param1:String, param2:int, param3:String, param4:Object, param5:Boolean = false) : void;
   }
}

