package com.sulake.core.runtime
{
   [SecureSWF(rename="true")]
   public class class_52 implements class_12
   {
      
      public function class_52()
      {
         super();
      }
      
      public function logError(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
      {
         class_21.log(param1,param4 != null ? param4.getStackTrace() : "");
      }
      
      public function set errorLogger(param1:class_22) : void
      {
      }
   }
}

