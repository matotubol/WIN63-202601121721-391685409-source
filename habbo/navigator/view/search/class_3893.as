package com.sulake.habbo.navigator.view.search
{
   public class class_3893
   {
      
      public static const DEFAULT:int = 0;
      
      public static const OWNER:int = 1;
      
      public static const ROOMNAME:int = 2;
      
      public static const TAG:int = 3;
      
      public static const GROUP:int = 4;
      
      public static const ANYTHING:int = 5;
      
      public static const FILTER_PREFIX:Array = ["","owner:","roomname:","tag:","group:",""];
      
      public function class_3893()
      {
         super();
      }
      
      public static function filterInInput(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ < FILTER_PREFIX.length)
         {
            if(param1.indexOf(FILTER_PREFIX[_loc2_]) == 0)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
   }
}

