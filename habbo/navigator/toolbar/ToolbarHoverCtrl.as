package com.sulake.habbo.navigator.toolbar
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.HabboNavigator;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
   
   public class ToolbarHoverCtrl
   {
      
      private static const ITEM_BG_COLOR_OVER:uint = 7433577;
      
      private static const ITEM_BG_COLOR_OUT:uint = 5723213;
      
      private const ITEM_LIST:String = "item_list";
      
      private const SIMPLE_ITEM_TAG:String = "SIMPLE_ITEM";
      
      private var _disposed:Boolean;
      
      private var _navigator:HabboNavigator;
      
      private var _localization:class_27;
      
      private var _window:class_1812;
      
      private var var_121:IItemListWindow;
      
      private var _simpleItemBase:class_1812;
      
      private var _hideTimeout:Timer;
      
      private var var_877:Boolean;
      
      public function ToolbarHoverCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         _localization = param1.localization;
         _window = class_1812(_navigator.getXmlWindow("toolbar_hover"));
         var_121 = IItemListWindow(_window.findChildByName("item_list"));
         _simpleItemBase = class_1812(var_121.getListItemByTag("SIMPLE_ITEM"));
         var_121.removeListItem(_simpleItemBase);
         _window.addEventListener("WME_OVER",onHoverOverWindow);
         _window.addEventListener("WME_HOVERING",onHoverOverWindow);
         _window.addEventListener("WME_OUT",onHoverOutWindow);
         addSimpleItem("navigator","${navigator.title}",onNavigatorClick);
         addSimpleItem("home","${toolbar.icon.label.exitroom.home}",onHomeClick);
         addSimpleItem("favorites","${navigator.navisel.myfavourites}",onFavouritesClick);
         addSimpleItem("create","${navigator.createroom.create}",onCreateRoomClick);
         addSimpleItem("history","${navigator.navisel.visitedrooms}",onHistoryClick);
         addSimpleItem("frequent","${navigator.navisel.frequentvisits}",onFrequentHistoryClick);
      }
      
      public function dispose() : void
      {
         _disposed = true;
         if(_hideTimeout)
         {
            _hideTimeout.reset();
            _hideTimeout = null;
         }
         var_121 = null;
         _window = null;
         _simpleItemBase = null;
         _navigator = null;
         _localization = null;
      }
      
      private function onNavigatorClick(param1:WindowMouseEvent) : void
      {
         _navigator.openNavigator();
         _navigator.goToMainView();
         hideForced();
      }
      
      private function onHomeClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = _navigator.data.homeRoomId;
         if(_loc2_ > -1)
         {
            _navigator.goToPrivateRoom(_loc2_);
            hideForced();
         }
      }
      
      private function onFavouritesClick(param1:WindowMouseEvent) : void
      {
         _navigator.showFavouriteRooms();
         hideForced();
      }
      
      private function onCreateRoomClick(param1:WindowMouseEvent) : void
      {
         _navigator.send(new CanCreateRoomMessageComposer());
         hideForced();
      }
      
      private function onHistoryClick(param1:WindowMouseEvent) : void
      {
         _navigator.showHistoryRooms();
         hideForced();
      }
      
      private function onFrequentHistoryClick(param1:WindowMouseEvent) : void
      {
         _navigator.showFrequentRooms();
         hideForced();
      }
      
      private function addSimpleItem(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:class_1812 = class_1812(_simpleItemBase.clone());
         _loc4_.name = param1;
         (_loc4_.getChildByName("text") as ITextWindow).text = param2;
         _loc4_.addEventListener("WME_CLICK",param3);
         _loc4_.addEventListener("WME_OVER",setItemBgHoverState);
         _loc4_.addEventListener("WME_OUT",setItemBgHoverState);
         var_121.addListItem(_loc4_);
      }
      
      public function show(param1:Point) : void
      {
         stopHideTimeout();
         _window.visible = true;
         _window.position = param1;
      }
      
      public function hideDelayed() : void
      {
         if(_disposed || var_877)
         {
            return;
         }
         startHideTimeout();
      }
      
      public function hideForced() : void
      {
         if(_disposed)
         {
            return;
         }
         stopHideTimeout();
         var_877 = false;
         _window.visible = false;
      }
      
      public function hide() : void
      {
         if(_disposed || var_877)
         {
            return;
         }
         stopHideTimeout();
         var_877 = false;
         _window.visible = false;
      }
      
      private function startHideTimeout() : void
      {
         if(!_hideTimeout)
         {
            _hideTimeout = new Timer(500,1);
            _hideTimeout.addEventListener("timerComplete",onHideTimeout);
            _hideTimeout.start();
         }
         else
         {
            _hideTimeout.reset();
            _hideTimeout.start();
         }
      }
      
      private function stopHideTimeout() : void
      {
         if(_hideTimeout && _hideTimeout.running)
         {
            _hideTimeout.reset();
         }
      }
      
      private function onHideTimeout(param1:Event) : void
      {
         hide();
      }
      
      private function setItemBgHoverState(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = false;
         var _loc4_:IRegionWindow = IRegionWindow(param1.target);
         var _loc3_:class_1993 = class_1993(_loc4_.findChildByName("background"));
         if(_loc3_)
         {
            _loc2_ = param1.type == "WME_OVER";
            _loc3_.color = _loc2_ ? 7433577 : 5723213;
            onHoverOutWindow(param1);
         }
      }
      
      private function onHoverOverWindow(param1:WindowMouseEvent) : void
      {
         var_877 = true;
      }
      
      private function onHoverOutWindow(param1:WindowMouseEvent) : void
      {
         if(_window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
         {
            var_877 = true;
            return;
         }
         var_877 = false;
         hideDelayed();
      }
   }
}

