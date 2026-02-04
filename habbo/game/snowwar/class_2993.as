package com.sulake.habbo.game.snowwar
{
   public class class_2993
   {
      
      public static const const_544:int = 0;
      
      public static const THROW_FAST_BALL:int = 1;
      
      public static const THROW_LONG_LOB_BALL:int = 2;
      
      public static const THROW_SHORT_LOB_BALL:int = 3;
      
      public static const THROW_DEFAULT:int = 4;
      
      public function class_2993()
      {
         super();
      }
      
      public static function getClickTypeOnTile(param1:Boolean, param2:Boolean) : int
      {
         if(param1)
         {
            if(param2)
            {
               return 3;
            }
            return 2;
         }
         if(param2)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getClickTypeOnOpponent(param1:Boolean, param2:Boolean) : int
      {
         if(param1)
         {
            if(param2)
            {
               return 3;
            }
            return 2;
         }
         if(param2)
         {
            return 1;
         }
         return 4;
      }
   }
}

