package com.sulake.habbo.communication
{
   public class WebApiRequest extends ApiRequest
   {
      
      private var var_3949:Boolean;
      
      public function WebApiRequest(param1:String, param2:String, param3:Boolean = true)
      {
         var_3949 = param3;
         super(param2,param1);
      }
      
      public function get requiresSession() : Boolean
      {
         return var_3949;
      }
   }
}

