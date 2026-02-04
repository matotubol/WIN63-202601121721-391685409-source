package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   
   public class PrizeContainer extends PrizeGridItem
   {
      
      private var var_2839:String;
      
      private var var_3730:int;
      
      private var var_5145:int;
      
      private var var_587:class_1800;
      
      private var var_5344:PrizeGridItem;
      
      public function PrizeContainer(param1:String, param2:int, param3:class_1800, param4:int, param5:HabboCatalog)
      {
         super(param5);
         var_2839 = param1;
         var_3730 = param2;
         var_587 = param3;
         var_5145 = param4;
      }
      
      public function setIcon(param1:IRoomEngine) : void
      {
         if(param1 == null)
         {
            return;
         }
         initProductIcon(param1,var_2839,var_3730);
      }
      
      public function get productItemType() : String
      {
         return var_2839;
      }
      
      public function get productItemTypeId() : int
      {
         return var_3730;
      }
      
      public function get gridItem() : PrizeGridItem
      {
         return var_5344;
      }
      
      public function get oddsLevelId() : int
      {
         return var_5145;
      }
      
      public function get title() : String
      {
         var _loc1_:class_1949 = null;
         if(var_587 == null)
         {
            _loc1_ = null;
            if(var_2839 == "chat_style")
            {
               _loc1_ = catalog.getProductData("chat_bubble_" + productItemTypeId);
            }
            return _loc1_ != null ? _loc1_.name : "";
         }
         return var_587.localizedName;
      }
   }
}

