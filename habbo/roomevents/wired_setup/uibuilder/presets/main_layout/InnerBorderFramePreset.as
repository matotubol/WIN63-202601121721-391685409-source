package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.components.class_1993;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.PaddedContainerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class InnerBorderFramePreset extends FramePreset
   {
      
      public function InnerBorderFramePreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:String, param7:int, param8:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      override protected function createListView(param1:Array) : void
      {
         var _loc9_:int = 0;
         var _loc12_:WiredUIPreset = null;
         var _loc10_:SimpleListViewPreset = null;
         var _loc7_:PaddedContainerPreset = null;
         var _loc2_:class_1993 = var_64.createInnerBorder();
         var _loc4_:int = var_64.sectionSpacing;
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         var _loc11_:Boolean = false;
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc12_ = param1[_loc9_];
            if(_loc12_ is FooterPreset)
            {
               FooterPreset(_loc12_).splitterVisible = false;
               _loc11_ = true;
               _loc10_ = var_182.createSimpleListView(true,_loc5_);
               _loc10_.spacing = 0;
               _loc10_.backgroundColor = var_64.backgroundColor;
               _loc7_ = var_182.createPaddedContainerPreset(_loc10_,9,8,9,8,_loc2_);
               _loc3_.push(_loc7_);
            }
            _loc3_.push(_loc12_);
            if(_loc12_ is HeaderPreset)
            {
               _headerPreset = _loc12_ as HeaderPreset;
               var _loc6_:Boolean = true;
            }
            _loc9_++;
         }
         _listPreset = var_182.createSimpleListView(true,_loc3_);
         _listPreset.backgroundColor = var_64.frameColor;
      }
   }
}

