package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class IlluminaHeaderPreset extends HeaderPreset
   {
      
      private var _name1Preset:TextPreset;
      
      private var _name2Preset:TextPreset;
      
      public function IlluminaHeaderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:class_2510, param6:int, param7:Function, param8:Function)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      override protected function createTopHeaderElement(param1:String, param2:class_2510) : WiredUIPreset
      {
         var _loc5_:Array = getNameParts(param1);
         var _loc3_:TextParam = new TextParam(1,true);
         _loc3_.fontSize = 11;
         _name1Preset = var_182.createText(_loc5_[0],_loc3_);
         _loc3_ = new TextParam(1,true);
         _loc3_.fontSize = var_64.headerNameFontSize;
         _loc3_.textColor = 4802889;
         _name2Preset = var_182.createText(_loc5_[1],_loc3_);
         var _loc4_:SimpleListViewPreset = var_182.createSimpleListView(true,[var_182.createSpacing(true,3),_name1Preset,_name2Preset]);
         _loc4_.spacing = -2;
         _loc4_.window.x = 3;
         return _loc4_;
      }
      
      private function getNameParts(param1:String) : Array
      {
         var _loc2_:Array = param1.split(":",2);
         while(_loc2_.length < 2)
         {
            _loc2_.push("");
         }
         while(_loc2_[1].indexOf(" ") == 0)
         {
            _loc2_[1] = _loc2_[1].substring(1);
         }
         _loc2_[0] = _loc2_[0].toUpperCase();
         return _loc2_;
      }
      
      override public function updateName(param1:String) : void
      {
         var _loc2_:Array = getNameParts(param1);
         _name1Preset.text = _loc2_[0];
         _name2Preset.text = _loc2_[1];
         resizeToWidth(_width);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _name1Preset = null;
         _name2Preset = null;
      }
   }
}

