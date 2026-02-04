package com.sulake.core.utils
{
   public class ErrorReportStorage
   {
      
      private static var var_1295:class_55 = new class_55();
      
      private static var var_2072:class_55 = new class_55();
      
      public function ErrorReportStorage()
      {
         super();
      }
      
      public static function getDebugData() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < var_2072.length)
         {
            if(_loc2_ == 0)
            {
               _loc1_ = var_2072.getWithIndex(_loc2_);
            }
            else
            {
               _loc1_ = _loc1_ + " ** " + var_2072.getWithIndex(_loc2_);
            }
            _loc2_++;
         }
         if(_loc1_.length > 400)
         {
            _loc1_ = _loc1_.substr(_loc1_.length - 400);
         }
         return _loc1_;
      }
      
      public static function addDebugData(param1:String, param2:String) : void
      {
         var_2072.remove(param1);
         var_2072.add(param1,param2);
      }
      
      public static function setParameter(param1:String, param2:String) : void
      {
         var_1295[param1] = param2;
      }
      
      public static function getParameter(param1:String) : String
      {
         return var_1295[param1];
      }
      
      public static function getParameterNames() : Array
      {
         return var_1295.getKeys();
      }
   }
}

