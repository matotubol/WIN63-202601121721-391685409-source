package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class HeaderPreset extends WiredUIPreset
   {
      
      public static const const_555:int = 0;
      
      public static const const_130:int = 1;
      
      public static const BUTTON_MODE_VARIABLE_MENU:int = 2;
      
      private var var_3829:int;
      
      private var _container:class_1812;
      
      private var _listPreset:SimpleListViewPreset;
      
      protected var _width:int;
      
      public function HeaderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:class_2510, param6:int, param7:Function, param8:Function)
      {
         super(param1,param2,param3);
         var_3829 = param6;
         _container = param2.createLayout("container_view") as class_1812;
         var _loc9_:Array = [];
         var _loc11_:WiredUIPreset = createTopHeaderElement(param4,param5);
         _loc9_.push(_loc11_);
         var _loc10_:TextualButtonPreset = null;
         if(param6 == 1)
         {
            _loc10_ = param2.createTextualButtonPreset(loc("wiredfurni.applysnapshot"),param7);
         }
         else if(param6 == 2)
         {
            _loc10_ = param2.createTextualButtonPreset(loc("wiredfurni.view_in_menu"),param8);
         }
         if(_loc10_ != null)
         {
            _loc9_.push(_loc10_.alignCenter());
         }
         _listPreset = param2.createSimpleListView(true,_loc9_);
         _container.addChild(_listPreset.window);
         _listPreset.window.x = var_64.headerMargin;
         _listPreset.window.y = var_64.headerMargin;
      }
      
      protected function createTopHeaderElement(param1:String, param2:class_2510) : WiredUIPreset
      {
         return null;
      }
      
      public function updateName(param1:String) : void
      {
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _width = param1;
         var _loc2_:int = var_64.headerMargin + (var_3829 == 0 ? var_64.headerMargin : var_64.headerBottomMarginWithLink);
         _listPreset.resizeToWidth(param1 - var_64.headerMargin * 2);
         _container.width = param1;
         _container.height = _listPreset.window.height + _loc2_;
      }
      
      override protected function get childPresets() : Array
      {
         return [_listPreset];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         _listPreset = null;
      }
   }
}

