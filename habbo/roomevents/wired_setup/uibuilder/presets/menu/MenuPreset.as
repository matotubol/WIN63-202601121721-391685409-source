package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.*;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.MenuItem;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.class_4008;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.class_4077;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.views.MenuItemView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.geom.Point;
   
   public class MenuPreset extends WiredUIPreset
   {
      
      public static const SPACER:class_4008 = new class_4077();
      
      private var _container:class_1812;
      
      private var var_2201:IRegionWindow;
      
      private var var_2447:class_1741;
      
      private var var_1089:Vector.<MenuItemView>;
      
      private var var_2530:class_1741;
      
      public function MenuPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:class_1741)
      {
         super(param1,param2,param3);
         var_2530 = param5;
         _container = param3.createQuickMenu();
         var _loc9_:IItemListWindow = menuList;
         var _loc7_:int = _container.width - _loc9_.width;
         var _loc8_:int = _container.height - _loc9_.height;
         var_2201 = _loc9_.removeListItem(_loc9_.findChildByName("menu_item_template")) as IRegionWindow;
         var_2447 = _loc9_.removeListItem(_loc9_.findChildByName("spacer_template"));
         var_1089 = new Vector.<MenuItemView>();
         var _loc12_:int = 0;
         for each(var _loc13_ in param4)
         {
            var _loc6_:MenuItem = _loc13_ as MenuItem;
            var _loc11_:class_4077 = _loc13_ as class_4077;
         }
         _container.width = _loc12_ + _loc7_ + param3.menuRightOffset;
         _container.height = _loc9_.height + _loc8_;
         _container.addEventListener("WE_DEACTIVATED",onDeactivate);
      }
      
      private function onDeactivate(param1:class_1758) : void
      {
         requestClose();
      }
      
      public function requestOpen() : void
      {
         var _loc1_:class_2052 = _roomEvents.windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.addChild(_container);
         }
         var _loc2_:Point = new Point();
         var_2530.getGlobalPosition(_loc2_);
         _container.x = _loc2_.x;
         _container.y = _loc2_.y + var_2530.height;
         _container.visible = true;
         _container.activate();
      }
      
      public function requestClose() : void
      {
         var _loc1_:class_2052 = _roomEvents.windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.removeChild(_container);
         }
      }
      
      public function setSelected(param1:int, param2:Boolean) : void
      {
         var_1089[param1].selected = param2;
      }
      
      public function getSelected(param1:int) : Boolean
      {
         return var_1089[param1].selected;
      }
      
      public function setDisabled(param1:int, param2:Boolean) : void
      {
         var_1089[param1].disabled = param2;
      }
      
      public function getDisabled(param1:int) : Boolean
      {
         return var_1089[param1].disabled;
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return false;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
      }
      
      override protected function get childPresets() : Array
      {
         return [];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         for each(var _loc1_ in var_1089)
         {
            _loc1_.dispose();
         }
         var_1089 = null;
         _container.dispose();
         _container = null;
         var_2201.dispose();
         var_2201 = null;
         var_2447.dispose();
         var_2447 = null;
         var_2530 = null;
      }
      
      private function get menuList() : IItemListWindow
      {
         return _container.findChildByName("menu_list") as IItemListWindow;
      }
      
      public function get menuItemTemplate() : IRegionWindow
      {
         return var_2201;
      }
   }
}

