package com.sulake.habbo.catalog.collectibles.util
{
   public class class_2502
   {
      
      private static const rarityColors:Object = {
         "common":6187373,
         "uncommon":24916,
         "rare":1202293,
         "epic":7150694,
         "legendary":8526848,
         "legendary+":11167744
      };
      
      public function class_2502()
      {
         super();
      }
      
      public static function getRarityColor(param1:String) : uint
      {
         var _loc2_:String = param1.toUpperCase();
         if(rarityColors.hasOwnProperty(_loc2_))
         {
            return rarityColors[_loc2_];
         }
         return 8947848;
      }
   }
}

