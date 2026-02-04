package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VolterHeaderPreset extends HeaderPreset
   {
      
      private var _namePreset:TextPreset;
      
      public function VolterHeaderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:class_2510, param6:int, param7:Function, param8:Function)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      override protected function createTopHeaderElement(param1:String, param2:class_2510) : WiredUIPreset
      {
         var _loc3_:TextParam = new TextParam(1,true);
         _loc3_.fontSize = var_64.headerNameFontSize;
         _namePreset = var_182.createText(param1,_loc3_);
         return var_182.createSimpleListView(false,[var_182.createBitmapWrapperPreset("wired_type_icons_icon_" + param2.getKey()),_namePreset]);
      }
      
      override public function updateName(param1:String) : void
      {
         _namePreset.text = param1;
         resizeToWidth(_width);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _namePreset = null;
      }
   }
}

