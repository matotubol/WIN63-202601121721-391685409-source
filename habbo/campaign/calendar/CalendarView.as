package com.sulake.habbo.campaign.calendar
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.campaign.HabboCampaigns;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import package_80.class_2349;
   
   public class CalendarView implements class_1829
   {
      
      private static const MARGIN:int = 75;
      
      private var var_55:HabboCampaigns;
      
      private var var_298:IModalDialog;
      
      private var var_639:int = -1;
      
      private var _itemsOnScreen:int;
      
      public function CalendarView(param1:HabboCampaigns, param2:class_38)
      {
         super();
         var_55 = param1;
         var_298 = param2.buildModalDialogFromXML(XML(var_55.assets.getAssetByName("campaign_calendar_xml").content));
         if(!var_298 || !var_298.rootWindow || !itemList)
         {
            return;
         }
         var _loc3_:class_1812 = itemList.getListItemAt(0) as class_1812;
         itemList.removeListItems();
         itemList.disableAutodrag = true;
         var _loc6_:int = calendarData.campaignDays;
         var _loc7_:int = 0;
         while(0 < _loc6_)
         {
            var _loc5_:class_1812 = CalendarItem.populateItem(_loc3_,calendarData,0);
            _loc5_.procedure = onInput;
            itemList.addListItem(null);
            _loc7_++;
         }
         var _loc4_:Stage = var_55.context.displayObjectContainer.stage;
         _loc4_.addEventListener("resize",onResize);
         window.procedure = onInput;
         onResize(null);
         setSelectedIndex(var_55.calendarData.currentDay);
      }
      
      public function dispose() : void
      {
         var _loc1_:Stage = null;
         if(var_298 != null)
         {
            _loc1_ = var_55.context.displayObjectContainer.stage;
            _loc1_.removeEventListener("resize",onResize);
            var_298.dispose();
            var_298 = null;
         }
      }
      
      public function setReceivedProduct(param1:class_1949, param2:String = null) : void
      {
         setInfoText("${campaign.calendar.heading.product.received}",param1.name);
         updateThumbnail(param2);
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         updateThumbnail(param2);
      }
      
      private function updateThumbnail(param1:Object) : void
      {
         var _loc2_:class_1812 = itemList.getListItemAt(var_639) as class_1812;
         if(!_loc2_)
         {
            return;
         }
         CalendarItem.updateThumbnail(_loc2_,param1);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function hide() : void
      {
         var_55.hideCalendar();
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc2_:Stage = var_55.context.displayObjectContainer.stage;
         _itemsOnScreen = Math.floor((_loc2_.stageWidth - 75 * 2) / (itemWidth + itemGap));
         var_298.rootWindow.width = calculateItemListWidth(_itemsOnScreen);
         var _loc3_:class_1741 = window.findChildByName("btn_forward");
         if(_loc3_)
         {
            _loc3_.x = scrollerWidth - window.findChildByName("btn_back").x - _loc3_.width;
         }
         _loc3_ = window.findChildByName("calendar_scrollbar");
         if(_loc3_)
         {
            _loc3_.width = scrollerWidth;
         }
         window.center();
         if(var_639 > -1)
         {
            setSelectedIndex(var_639);
         }
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         switch(param2.name)
         {
            case "btn_present":
               _loc3_ = itemList.getListItemIndex(param1.target.parent);
               if(_loc3_ < 0)
               {
                  return;
               }
               if(_loc3_ != var_639)
               {
                  setSelectedIndex(_loc3_);
                  break;
               }
               var_55.openPackage(var_639);
               break;
            case "btn_back":
               setSelectedIndex(var_639 - 1);
               break;
            case "btn_forward":
               setSelectedIndex(var_639 + 1);
               break;
            case "btn_force_open":
               var_55.openPackageAsStaff(var_639);
               break;
            case "header_button_close":
               hide();
         }
      }
      
      private function setSelectedIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= calendarData.campaignDays)
         {
            return;
         }
         var_639 = param1;
         itemList.scrollH = calculateCenteredItemScrollH(var_639);
         var _loc6_:int = 0;
         while(0 < calendarData.campaignDays)
         {
            var _loc2_:class_1812 = itemList.getListItemAt(0) as class_1812;
            CalendarItem.updateState(null,calendarData,0,param1);
            _loc6_++;
         }
         CalendarSpinnerUtil.createGradients(this,var_639);
         if(var_55.isAnyRoomController)
         {
            var _loc7_:class_1775 = window.findChildByName("btn_force_open") as class_1775;
            _loc7_.visible = true;
         }
         var _loc3_:int = CalendarItem.resolveDayState(calendarData,param1);
         if(var_639 < 0)
         {
            setInfoText(null,null);
         }
         else
         {
            switch(_loc3_ - 1)
            {
               case 0:
                  var _loc5_:String = "${campaign.calendar.info.unlocked}";
                  break;
               case 1:
                  _loc5_ = "${campaign.calendar.info.available.desktop}";
                  break;
               case 2:
                  _loc5_ = "${campaign.calendar.info.expired}";
                  break;
               case 3:
                  _loc5_ = "${campaign.calendar.info.future}";
            }
            var _loc4_:String = var_55.localizationManager.getLocalization("campaign.calendar.heading.day") || "";
            _loc4_ = _loc4_.replace("%number%",var_639 + 1);
            setInfoText(null,null);
         }
      }
      
      private function setInfoText(param1:String, param2:String) : void
      {
         (window.findChildByName("info_heading") as ITextWindow).text = param1 || "";
         (window.findChildByName("info_body") as ITextWindow).text = param2 || "";
      }
      
      private function startItemWiggle(param1:int) : void
      {
      }
      
      public function get window() : class_2250
      {
         return var_298 ? var_298.rootWindow as class_2250 : null;
      }
      
      private function getItemIndexAt(param1:int) : int
      {
         return Math.floor((itemList.scrollH * itemList.maxScrollH + param1) / ((itemList.maxScrollH + scrollerWidth) / itemList.numListItems));
      }
      
      private function calculateCenteredItemScrollH(param1:int) : Number
      {
         return (calculateItemListWidth(param1) - (scrollerWidth - itemWidth) * 0.5) / itemList.maxScrollH;
      }
      
      public function calculateItemListWidth(param1:int) : Number
      {
         return param1 * itemWidth + Math.max(0,param1 - 1) * itemGap;
      }
      
      public function get itemList() : IItemListWindow
      {
         return window ? window.findChildByName("calendar_itemlist") as IItemListWindow : null;
      }
      
      public function get itemWidth() : int
      {
         return itemList && itemList.numListItems > 0 ? itemList.getListItemAt(0).width : 0;
      }
      
      public function get itemGap() : int
      {
         return itemList ? itemList.spacing : 0;
      }
      
      public function get scrollerWidth() : int
      {
         return window && window.content ? window.content.width : 0;
      }
      
      private function get calendarData() : class_2349
      {
         return var_55.calendarData;
      }
   }
}

