package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   
   public class FurniProductContainer extends ProductContainer
   {
      
      private var var_587:class_1800;
      
      public function FurniProductContainer(param1:class_1793, param2:Vector.<class_1857>, param3:HabboCatalog, param4:class_1800)
      {
         super(param1,param2,param3);
         var_587 = param4;
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         var _loc3_:class_2198 = null;
         switch(var_587.type)
         {
            case "s":
               _loc3_ = catalog.roomEngine.getFurnitureIcon(var_587.id,this);
               break;
            case "i":
               _loc3_ = catalog.roomEngine.getWallItemIcon(var_587.id,this);
         }
         if(_loc3_)
         {
            setIconImage(_loc3_.data,true);
         }
      }
      
      override public function activate() : void
      {
         super.activate();
         if(var_587.rentOfferId > -1 && catalog.catalogType != "BUILDERS_CLUB")
         {
            catalog.sendGetProductOffer(var_587.rentOfferId);
         }
         else
         {
            catalog.sendGetProductOffer(var_587.purchaseOfferId);
         }
      }
      
      override public function get isLazy() : Boolean
      {
         return true;
      }
   }
}

