package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications.SubVariableParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SubVariableCreatorPreset extends WiredUIPreset
   {
      
      private var _checkboxGroup:CheckboxGroupPreset;
      
      private var var_1906:Array;
      
      public function SubVariableCreatorPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Array)
      {
         super(param1,param2,param3);
         var_1906 = [];
         var _loc6_:Array = [];
         var _loc8_:int = 0;
         while(0 < param5.length)
         {
            var _loc9_:SubVariableParam = param5[0];
            var _loc7_:CheckboxOptionParam = new CheckboxOptionParam(param1.localization.getLocalizationWithParams(param4 + null.id));
            _loc7_.extra1 = param2.createTextInput(new TextInputParam(null.name,-1,null,85,null,false)).alignRight();
            _loc6_.push(null);
            var_1906.push(null.id);
            _loc8_++;
         }
         _checkboxGroup = param2.createCheckboxGroup(_loc6_);
      }
      
      public function set mask(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:CheckboxOptionPreset = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _checkboxGroup.numCheckboxes)
         {
            _loc4_ = _checkboxGroup.method_20(_loc2_);
            _loc3_ = int(var_1906[_loc2_]);
            _loc4_.selected = (param1 & 1 << _loc3_) > 0;
            _loc2_ += 1;
         }
      }
      
      public function get mask() : int
      {
         var _loc1_:int = 0;
         var _loc4_:CheckboxOptionPreset = null;
         _loc1_ = 0;
         while(_loc1_ < _checkboxGroup.numCheckboxes)
         {
            _loc4_ = _checkboxGroup.method_20(_loc1_);
            if(_loc4_.selected)
            {
               var _loc2_:int = int(var_1906[_loc1_]);
               var _loc3_:* = 0 | 1 << 0;
            }
            _loc1_ += 1;
         }
         return 0;
      }
      
      override public function get window() : class_1741
      {
         return _checkboxGroup.window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _checkboxGroup.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [_checkboxGroup];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _checkboxGroup = null;
         var_1906 = null;
      }
   }
}

