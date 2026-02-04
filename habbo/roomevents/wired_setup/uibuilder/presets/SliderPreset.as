package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowControllerNew;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SliderPreset extends WiredUIPreset
   {
      
      private var _container:class_1812;
      
      private var _listPreset:SimpleListViewPreset;
      
      private var var_1174:SliderWindowControllerNew;
      
      public function SliderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Number = 0, param5:Number = 1, param6:Number = 0)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("container_view") as class_1812;
         var _loc7_:class_1812 = param3.createSlider();
         var_1174 = new SliderWindowControllerNew(_loc7_,param4,param5,param6);
         _listPreset = param2.createSimpleListView(false,[param2.createIconButtonPreset("left",var_1174.moveSliderToLeft),wrapWindow(_loc7_),param2.createIconButtonPreset("right",var_1174.moveSliderToRight)],true);
         _listPreset.spacing = param3.LRContainerSpacing;
         _container.addChild(_listPreset.window);
         _listPreset.window.x = param3.LRContainerMargin;
         _listPreset.window.y = param3.LRContainerTopBottomPadding;
      }
      
      public function set value(param1:int) : void
      {
         var_1174.setValue(param1);
      }
      
      public function get value() : int
      {
         return var_1174.getValue();
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         var_1174.addEventListener(param1,param2);
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         _listPreset.resizeToWidth(param1 - var_64.LRContainerMargin * 2);
         _container.height = _listPreset.window.height + 2 * var_64.LRContainerTopBottomPadding;
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
         var_1174.dispose();
         var_1174 = null;
      }
   }
}

