package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.session.furniture.class_1800;
   import package_48.PrizeLevelMessageData;
   import package_48.PrizeMessageData;
   
   public class PrizeLevelContainer
   {
      
      private var var_3115:int;
      
      private var var_1475:Array;
      
      private var var_4048:int;
      
      public function PrizeLevelContainer(param1:PrizeLevelMessageData, param2:HabboCatalog)
      {
         super();
         var_3115 = param1.prizeLevelId;
         var_4048 = param1.probabilityDenominator;
         var_1475 = [];
         var _loc4_:int = 0;
         while(0 < param1.prizes.length)
         {
            var _loc3_:PrizeMessageData = param1.prizes[0];
            if(null.isDeal)
            {
               var _loc6_:PrizeContainer = new DealPrizeContainer(null.subProducts,var_3115,param2);
            }
            else
            {
               var _loc5_:class_1800 = param2.getFurnitureData(null.productItemTypeId,null.productItemType);
               _loc6_ = new PrizeContainer(null.productItemType,null.productItemTypeId,null,var_3115,param2);
            }
            var_1475.push(null);
            _loc4_++;
         }
      }
      
      public function get prizeLevelId() : int
      {
         return var_3115;
      }
      
      public function get prizes() : Array
      {
         return var_1475;
      }
      
      public function get probabilityDenominator() : int
      {
         return var_4048;
      }
   }
}

