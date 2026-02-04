package com.sulake.core.runtime.exceptions
{
   import flash.utils.getQualifiedClassName;
   
   public class Exception extends Error
   {
      
      private var _cause:Error;
      
      public function Exception(param1:String, param2:int = 0, param3:Error = null)
      {
         super(param1,param2);
         _cause = param3;
      }
      
      public static function getChainedStackTrace(param1:Error) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         while(param1 != null)
         {
            _loc3_ = param1.getStackTrace();
            if(_loc3_ != null)
            {
               if(_loc2_ == null)
               {
                  _loc2_ = _loc3_;
               }
               else
               {
                  _loc2_ += "\ncaused by ";
                  _loc2_ += _loc3_;
               }
            }
            if(param1 is Exception)
            {
               param1 = (param1 as Exception).cause;
            }
            else
            {
               param1 = null;
            }
         }
         return _loc2_;
      }
      
      public function get cause() : Error
      {
         return _cause;
      }
      
      public function toString() : String
      {
         var _loc1_:String = getQualifiedClassName(this) + ": " + super.message;
         if(_cause != null)
         {
            _loc1_ += ", caused by ";
            _loc1_ += _cause.toString();
         }
         return _loc1_;
      }
   }
}

