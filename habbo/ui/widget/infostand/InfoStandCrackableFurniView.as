package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.object.data.class_3238;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   
   public class InfoStandCrackableFurniView extends InfoStandFurniView
   {
      
      public function InfoStandCrackableFurniView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         super.update(param1);
         var _loc2_:class_3238 = param1.stuffData as class_3238;
         showButton("use",true);
         var_34.visible = true;
         setHitsAndTarget(_loc2_.hits,_loc2_.target);
      }
      
      private function setHitsAndTarget(param1:int, param2:int) : void
      {
         var _loc3_:class_1741 = var_108.getListItemByName("hits_remaining");
         if(_loc3_ == null)
         {
            return;
         }
         var_16.localizations.registerParameter("infostand.crackable_furni.hits_remaining","hits",String(param1));
         var_16.localizations.registerParameter("infostand.crackable_furni.hits_remaining","target",String(param2));
         _loc3_.visible = true;
         updateWindow();
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc4_:XmlAsset = var_16.assets.getAssetByName("crackable_furni_view") as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_31 = _window.getListItemByName("info_border") as class_1993;
         var_34 = _window.getListItemByName("button_list") as IItemListWindow;
         if(var_31 != null)
         {
            var_108 = var_31.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_16.mainContainer.addChild(_window);
         var _loc3_:class_1741 = var_31.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         if(var_34 != null)
         {
            var _loc5_:int = 0;
            while(0 < var_34.numListItems)
            {
               var _loc2_:class_1741 = var_34.getListItemAt(0);
               null.addEventListener("WME_CLICK",onButtonClicked);
               _loc5_++;
            }
         }
         var_350 = var_31.findChildByTag("catalog");
         if(var_350 != null)
         {
            var_350.addEventListener("WME_CLICK",onCatalogButtonClicked);
         }
         var_356 = var_31.findChildByName("rent_button");
         if(var_356 != null)
         {
            var_356.addEventListener("WME_CLICK",onRentButtonClicked);
         }
         var_348 = var_31.findChildByName("extend_button");
         if(var_348 != null)
         {
            var_348.addEventListener("WME_CLICK",onExtendButtonClicked);
         }
         var_344 = var_31.findChildByName("buyout_button");
         if(var_344 != null)
         {
            var_344.addEventListener("WME_CLICK",onBuyoutButtonClicked);
         }
         var _loc6_:IRegionWindow = var_108.getListItemByName("owner_region") as IRegionWindow;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc6_.addEventListener("WME_OVER",onOwnerRegion);
            _loc6_.addEventListener("WME_OUT",onOwnerRegion);
         }
      }
   }
}

