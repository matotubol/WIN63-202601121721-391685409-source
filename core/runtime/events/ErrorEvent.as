package com.sulake.core.runtime.events
{
   public class ErrorEvent extends WarningEvent
   {
      
      protected var var_191:int;
      
      protected var var_3768:Boolean;
      
      protected var var_1527:Error;
      
      public function ErrorEvent(param1:String, param2:String, param3:Boolean, param4:int, param5:Error = null)
      {
         var_3768 = param3;
         var_191 = param4;
         var_1527 = param5;
         super(param1,param2);
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get critical() : Boolean
      {
         return var_3768;
      }
      
      public function get error() : Error
      {
         return var_1527;
      }
   }
}

